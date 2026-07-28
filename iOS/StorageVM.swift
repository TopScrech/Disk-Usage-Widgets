import Foundation
import WidgetKit

@Observable
final class StorageVM {
    private(set) var snapshot: StorageSnapshot?
    private(set) var externalDrives: [ExternalDriveSnapshot] = []
    private(set) var errorMessage: String?
    private(set) var externalDriveErrorMessage: String?
    private(set) var isRefreshing = false

    private var externalDriveBookmarks: [Data]

    var hasSavedExternalDrives: Bool {
        !externalDriveBookmarks.isEmpty
    }

    init() {
        externalDriveBookmarks = UserDefaults.standard.array(
            forKey: Self.externalDriveBookmarksKey
        ) as? [Data] ?? []
    }

    func refresh() {
        isRefreshing = true
        defer { isRefreshing = false }

        do {
            snapshot = try readStorage(at: .documentsDirectory, fallbackName: "Device Storage")
            errorMessage = nil
            WidgetCenter.shared.reloadAllTimelines()
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

    func forgetExternalDrive(id: Data) {
        externalDriveBookmarks.removeAll { $0 == id }
        externalDrives.removeAll { $0.id == id }
        saveExternalDriveBookmarks()
    }

    private func addExternalDrive(at url: URL) {
        do {
            let bookmark = try url.bookmarkData(
                options: .minimalBookmark,
                includingResourceValuesForKeys: nil,
                relativeTo: nil
            )

            if !externalDriveBookmarks.contains(where: { bookmarkTargetsSameURL($0, url) }) {
                externalDriveBookmarks.append(bookmark)
                saveExternalDriveBookmarks()
            }

            externalDriveErrorMessage = nil
            refreshExternalDrives()
        } catch {
            externalDriveErrorMessage = error.localizedDescription
        }
    }

    private func refreshExternalDrives() {
        externalDrives = externalDriveBookmarks.compactMap { bookmark in
            do {
                var isStale = false
                let url = try URL(
                    resolvingBookmarkData: bookmark,
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

                return ExternalDriveSnapshot(
                    id: bookmark,
                    storage: try readStorage(at: url, fallbackName: "External Drive")
                )
            } catch {
                return nil
            }
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

    private func saveExternalDriveBookmarks() {
        UserDefaults.standard.set(externalDriveBookmarks, forKey: Self.externalDriveBookmarksKey)
    }

    private static let externalDriveBookmarksKey = "externalDriveBookmarks"
}
