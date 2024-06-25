import ScrechKit

@Observable
final class VM {
    let fm = FileManager.default
    
    var disks: [DiskEntry] = []
    
    func listAvailableDisks() {
        guard let volumes = fm.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: .skipHiddenVolumes) else {
            print("Failed to retrieve mounted volume URLs.")
            return
        }
        
        var foundDisks: [DiskEntry] = []
        
        for volume in volumes {
            do {
                let resourceValues = try volume.resourceValues(forKeys: [.volumeNameKey, .volumeLocalizedNameKey])
                
                guard let volumeName = resourceValues.volumeName,
                      let volumeLocalizedName = resourceValues.volumeLocalizedName
                else { return }
                
                let space =      try fm.volumeFreeDiskSpace(volume)
                let totalSpace = try fm.volumeTotalDiskSpace(volume)
                
                let disk = DiskEntry(
                    url: volume,
                    name: volumeName,
                    localizedName: volumeLocalizedName,
                    freeSpaceBytes: space,
                    totalSpaceBytes: totalSpace
                )
                
                print(disk.freeSpaceBytes)
                
                foundDisks.append(disk)
            } catch {
                print("Error retrieving resource values for \(volume): \(error.localizedDescription)")
            }
        }
        
        disks = foundDisks
    }
}
