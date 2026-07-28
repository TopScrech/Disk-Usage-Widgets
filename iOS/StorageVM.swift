import Foundation
import WidgetKit

@Observable
final class StorageVM {
    private(set) var snapshot: StorageSnapshot?
    private(set) var errorMessage: String?
    private(set) var isRefreshing = false

    func refresh() {
        isRefreshing = true
        defer { isRefreshing = false }

        do {
            snapshot = try readStorage()
            errorMessage = nil
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func readStorage() throws -> StorageSnapshot {
        let storageURL = URL.documentsDirectory
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
            name: values.volumeLocalizedName ?? values.volumeName ?? "Device Storage",
            fileSystem: values.volumeTypeName?.uppercased() ?? "APFS",
            availableBytes: min(max(availableBytes, 0), totalBytes),
            totalBytes: totalBytes,
            updatedAt: .now
        )
    }
}
