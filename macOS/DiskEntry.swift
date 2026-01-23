import ScrechKit

struct DiskEntry: Identifiable, Equatable {
    let id = UUID()
    let url: URL?
    let name: String
    let type: String
    let isLocal: Bool
    let isEjectable: Bool
    let isEncrypted: Bool
    let localizedName: String
    let freeSpaceBytes: Int
    let totalSpaceBytes: Int
    
    var usedSpaceBytes: Int {
        totalSpaceBytes - freeSpaceBytes
    }
    
    var icon: String {
        isLocal ? "externaldrive" : "externaldrive.connected.to.line.below"
    }
    
    var freeSpace: String {
        formatBytes(freeSpaceBytes)
    }
    
    var usedSpace: String {
        formatBytes(totalSpaceBytes - freeSpaceBytes)
    }
    
    var totalSpace: String {
        formatBytes(totalSpaceBytes)
    }
    
    var freeSpacePercentage: String {
        let value = (Double(freeSpaceBytes) / Double(totalSpaceBytes))
        return value.formatted(.percentRounded(2))
    }
    
    var usedSpacePercentage: String {
        let value = (Double(totalSpaceBytes - freeSpaceBytes) / Double(totalSpaceBytes))
        return value.formatted(.percentRounded(2))
    }
}
