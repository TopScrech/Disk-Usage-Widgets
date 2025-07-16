import ScrechKit

enum Utils {
    static let previewDisk = DiskEntry(
        url: URL(string: ""),
        name: "Preview SSD",
        type: "APFS",
        isLocal: true,
        isEjectable: true,
        isEncrypted: true,
        localizedName: "Превью SSD",
        freeSpaceBytes: 900110000000,
        totalSpaceBytes: 900110000000 * 2
    )
    
    static let previewDisks = [
        previewDisk, previewDisk, previewDisk
    ]
    
    static var buildNumber: String {
        Bundle.build ?? "Unknown"
    }
}
