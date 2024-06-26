import ScrechKit

struct DiskEntry: Identifiable {
    let id = UUID()
    let url: URL?
    let name: String
    let type: String
    let isLocal: Bool
    let isEjectable: Bool
    let isEncrypted: Bool
    let localizedName: String
    let freeSpaceBytes: Int64
    let totalSpaceBytes: Int
    
    var icon: String {
        isLocal ? "externaldrive" : "externaldrive.connected.to.line.below"
    }
    
    var freeSpace: String {
        formatBytes(freeSpaceBytes)
    }
    
    var usedSpace: String {
        formatBytes(totalSpaceBytes - Int(freeSpaceBytes))
    }
    
    var totalSpace: String {
        formatBytes(totalSpaceBytes)
    }
    
    var freeSpacePercentage: String {
        String(format: "%.2f %%", (Double(freeSpaceBytes) / Double(totalSpaceBytes)) * 100)
    }
    
    var usedSpacePercentage: String {
        String(format: "%.2f %%", (Double(totalSpaceBytes - Int(freeSpaceBytes)) / Double(totalSpaceBytes)) * 100)
    }
}
