import Foundation

@Observable
final class VM {
    let fm = FileManager.default
    
    var disks: [DiskEntry] = []
    
    init() {
        listAvailableDisks()
    }
    
    func listAvailableDisks() {
        guard let volumes = fm.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: .skipHiddenVolumes) else {
            print("Failed to retrieve mounted volume URLs.")
            return
        }
        
        var foundDisks: [DiskEntry] = []
        
        for volume in volumes {
            do {
                let resourceValues = try volume.resourceValues(forKeys: [.volumeNameKey, .volumeLocalizedNameKey])
                
                if let volumeName = resourceValues.volumeName, let volumeLocalizedName = resourceValues.volumeLocalizedName, let url = URL(string: "file:///") {
                    let space =      try fm.volumeFreeDiskSpace(url)
                    let totalSpace = try fm.volumeTotalDiskSpace(url)
                    
                    let disk = DiskEntry(
                        url: volume,
                        name: volumeName,
                        localizedName: volumeLocalizedName,
                        freeSpaceBytes: space,
                        totalSpaceBytes: totalSpace
                    )
                    
                    foundDisks.append(disk)
                }
            } catch {
                print("Error retrieving resource values for \(volume): \(error.localizedDescription)")
            }
        }
        
        disks = foundDisks
    }
}
