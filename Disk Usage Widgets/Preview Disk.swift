import Foundation

final class Preview {
    static let disk = DiskEntry(
        url: URL(string: ""),
        name: "Preview SSD",
        type: "APFS",
        isLocal: true,
        isEjectable: true,
        isEncrypted: true,
        localizedName: "Превью SSD",
        freeSpaceBytes: 900000000000,
        totalSpaceBytes: 900000000000 * 2
    )
}
