import Foundation
import WidgetKit

@Observable
final class StorageVM {
    private(set) var snapshot: StorageSnapshot?
    private(set) var externalDrives: [ExternalDriveSnapshot] = []
    private(set) var savedExternalDrives: [SavedExternalDrive]
    private(set) var errorMessage: String?
    private(set) var externalDriveErrorMessage: String?
    private(set) var isRefreshing = false

    var hasSavedExternalDrives: Bool {
        !savedExternalDrives.isEmpty
    }

    init() {
        if
            let savedData = UserDefaults.standard.data(forKey: Self.savedExternalDrivesKey),
            let drives = try? JSONDecoder().decode([SavedExternalDrive].self, from: savedData)
        {
            savedExternalDrives = drives
        } else {
            let bookmarks = UserDefaults.standard.array(
                forKey: Self.legacyExternalDriveBookmarksKey
            ) as? [Data] ?? []

            savedExternalDrives = bookmarks.map {
                SavedExternalDrive(
                    id: UUID(),
                    name: Self.savedDriveName(for: $0),
                    bookmark: $0
                )
            }

            saveExternalDrives()
        }
    }

    func refresh() {
        refresh(reloadWidgets: true)
    }

    func monitorStorage() async {
        refresh()

        while !Task.isCancelled {
            do {
                try await Task.sleep(for: .seconds(1))
            } catch {
                return
            }

            refresh(reloadWidgets: false)
        }
    }

    func isExternalDriveConnected(id: UUID) -> Bool {
        externalDrives.contains { $0.id == id }
    }

    func clearSavedExternalDrives() {
        savedExternalDrives = []
        externalDrives = []
        externalDriveErrorMessage = nil
        saveExternalDrives()
    }

    private func refresh(reloadWidgets: Bool) {
        isRefreshing = true
        defer { isRefreshing = false }

        do {
            snapshot = try readStorage(at: .documentsDirectory, fallbackName: "Device Storage")
            errorMessage = nil

            if reloadWidgets {
                WidgetCenter.shared.reloadAllTimelines()
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        refreshExternalDrives()
    }

    func addExternalDrive(from result: Result<URL, any Error>) {
        switch result {
        case .success(let url):
            addExternalDrive(at: url)
        case .failure(let error):
            externalDriveErrorMessage = error.localizedDescription
        }
    }

    func forgetExternalDrive(id: UUID) {
        savedExternalDrives.removeAll { $0.id == id }
        externalDrives.removeAll { $0.id == id }
        saveExternalDrives()
    }

    private func addExternalDrive(at url: URL) {
        do {
            let isAccessing = url.startAccessingSecurityScopedResource()
            defer {
                if isAccessing {
                    url.stopAccessingSecurityScopedResource()
                }
            }

            let storage = try readStorage(at: url, fallbackName: "External Drive")
            let bookmark = try url.bookmarkData(
                options: .minimalBookmark,
                includingResourceValuesForKeys: nil,
                relativeTo: nil
            )

            if !savedExternalDrives.contains(where: { bookmarkTargetsSameURL($0.bookmark, url) }) {
                savedExternalDrives.append(
                    SavedExternalDrive(
                        id: UUID(),
                        name: storage.name,
                        bookmark: bookmark
                    )
                )
                saveExternalDrives()
            }

            externalDriveErrorMessage = nil
            refreshExternalDrives()
        } catch {
            externalDriveErrorMessage = error.localizedDescription
        }
    }

    private func refreshExternalDrives() {
        var refreshedDrives: [ExternalDriveSnapshot] = []
        var updatedSavedDrives = savedExternalDrives

        for index in updatedSavedDrives.indices {
            do {
                var isStale = false
                let url = try URL(
                    resolvingBookmarkData: updatedSavedDrives[index].bookmark,
                    options: .withoutUI,
                    relativeTo: nil,
                    bookmarkDataIsStale: &isStale
                )
                let isAccessing = url.startAccessingSecurityScopedResource()
                defer {
                    if isAccessing {
                        url.stopAccessingSecurityScopedResource()
                    }
                }

                let storage = try readStorage(at: url, fallbackName: "External Drive")
                updatedSavedDrives[index].name = storage.name
                refreshedDrives.append(
                    ExternalDriveSnapshot(
                        id: updatedSavedDrives[index].id,
                        storage: storage
                    )
                )
            } catch {
                continue
            }
        }

        externalDrives = refreshedDrives

        if updatedSavedDrives != savedExternalDrives {
            savedExternalDrives = updatedSavedDrives
            saveExternalDrives()
        }
    }

    private func readStorage(at storageURL: URL, fallbackName: String) throws -> StorageSnapshot {
        let values = try storageURL.resourceValues(
            forKeys: [
                .volumeLocalizedNameKey,
                .volumeNameKey,
                .volumeTypeNameKey,
                .volumeAvailableCapacityForImportantUsageKey,
                .volumeAvailableCapacityKey,
                .volumeTotalCapacityKey
            ]
        )

        guard let totalBytes = values.volumeTotalCapacity.map(Int64.init), totalBytes > 0 else {
            throw StorageReadError.capacityUnavailable
        }

        let availableBytes: Int64
        if let importantCapacity = values.volumeAvailableCapacityForImportantUsage {
            availableBytes = importantCapacity
        } else if let capacity = values.volumeAvailableCapacity {
            availableBytes = Int64(capacity)
        } else {
            throw StorageReadError.capacityUnavailable
        }

        return StorageSnapshot(
            name: values.volumeLocalizedName ?? values.volumeName ?? fallbackName,
            fileSystem: values.volumeTypeName?.uppercased() ?? "APFS",
            availableBytes: min(max(availableBytes, 0), totalBytes),
            totalBytes: totalBytes,
            updatedAt: .now
        )
    }

    private func bookmarkTargetsSameURL(_ bookmark: Data, _ url: URL) -> Bool {
        var isStale = false
        guard let bookmarkedURL = try? URL(
            resolvingBookmarkData: bookmark,
            options: .withoutUI,
            relativeTo: nil,
            bookmarkDataIsStale: &isStale
        ) else {
            return false
        }

        return bookmarkedURL.standardizedFileURL == url.standardizedFileURL
    }

    private func saveExternalDrives() {
        guard let data = try? JSONEncoder().encode(savedExternalDrives) else { return }
        UserDefaults.standard.set(data, forKey: Self.savedExternalDrivesKey)
    }

    private static func savedDriveName(for bookmark: Data) -> String {
        var isStale = false
        guard let url = try? URL(
            resolvingBookmarkData: bookmark,
            options: .withoutUI,
            relativeTo: nil,
            bookmarkDataIsStale: &isStale
        ) else {
            return "External Drive"
        }

        return url.lastPathComponent.isEmpty ? "External Drive" : url.lastPathComponent
    }

    private static let savedExternalDrivesKey = "savedExternalDrives"
    private static let legacyExternalDriveBookmarksKey = "externalDriveBookmarks"
}
