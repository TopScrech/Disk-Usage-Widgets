import Foundation

extension StorageSnapshot {
    static let preview = StorageSnapshot(
        name: "Device Storage",
        fileSystem: "APFS",
        availableBytes: 96_000_000_000,
        totalBytes: 256_000_000_000,
        updatedAt: .now
    )
}
