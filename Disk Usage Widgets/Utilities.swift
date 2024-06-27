import Foundation

final class Utilities {
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
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            buildNumber
        } else {
            "Unknown"
        }
    }
}
