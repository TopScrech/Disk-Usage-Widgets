import ScrechKit

struct DiskEntry: Identifiable {
    let id = UUID()
    let url: URL?
    let name: String
    let localizedName: String
    let freeSpaceBytes: Int64
    let totalSpaceBytes: Int
    
    var freeSpace: String {
        formatBytes(freeSpaceBytes)
    }
    
    var totalSpace: String {
        formatBytes(totalSpaceBytes)
    }
}
