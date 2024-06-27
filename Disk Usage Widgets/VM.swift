import ScrechKit

@Observable
final class VM {
    var disks: [DiskEntry] = []
    
    private let fm = FileManager.default
    
    func listAvailableDisks() {
        guard let volumes = fm.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: .skipHiddenVolumes) else {
            print("Failed to retrieve mounted volume URLs.")
            return
        }
        
        var foundDisks: [DiskEntry] = []
        
        for volume in volumes {
            do {
                let keys: Set<URLResourceKey> = [
                    .volumeNameKey,
                    .volumeLocalizedNameKey,
                    .volumeIsLocalKey,
                    .volumeTypeNameKey,
                    .volumeIsEjectableKey,
                    .volumeIsEncryptedKey
                ]
                
                let resourceValues = try volume.resourceValues(forKeys: keys)
                
                guard let name =          resourceValues.volumeName,
                      let localizedName = resourceValues.volumeLocalizedName,
                      let isLocal =       resourceValues.volumeIsLocal,
                      let type =          resourceValues.volumeTypeName,
                      let isEjectable =   resourceValues.volumeIsEjectable,
                      let isEncrypted =   resourceValues.volumeIsEncrypted
                else { return }
                
                let space =      try fm.volumeFreeDiskSpace(volume)
                let totalSpace = try fm.volumeTotalDiskSpace(volume)
                
                let disk = DiskEntry(
                    url: volume,
                    name: name,
                    type: type.uppercased(),
                    isLocal: isLocal,
                    isEjectable: isEjectable,
                    isEncrypted: isEncrypted,
                    localizedName: localizedName,
                    freeSpaceBytes: space,
                    totalSpaceBytes: totalSpace
                )
                
                foundDisks.append(disk)
            } catch {
                print("Error retrieving resource values for \(volume): \(error.localizedDescription)")
            }
        }
        
        disks = foundDisks
    }
    
    private func processVolume(_ volume: URL) -> DiskEntry? {
        do {
            let keys: Set<URLResourceKey> = [
                .volumeNameKey,
                .volumeLocalizedNameKey,
                .volumeIsLocalKey,
                .volumeTypeNameKey,
                .volumeIsEjectableKey,
                .volumeIsEncryptedKey
            ]
            
            let resourceValues = try volume.resourceValues(forKeys: keys)
            
            guard let name =          resourceValues.volumeName,
                  let localizedName = resourceValues.volumeLocalizedName,
                  let isLocal =       resourceValues.volumeIsLocal,
                  let type =          resourceValues.volumeTypeName,
                  let isEjectable =   resourceValues.volumeIsEjectable,
                  let isEncrypted =   resourceValues.volumeIsEncrypted
            else { return nil }
            
            let space =      try fm.volumeFreeDiskSpace(volume)
            let totalSpace = try fm.volumeTotalDiskSpace(volume)
            
            let disk = DiskEntry(
                url: volume,
                name: name,
                type: type.uppercased(),
                isLocal: isLocal,
                isEjectable: isEjectable,
                isEncrypted: isEncrypted,
                localizedName: localizedName,
                freeSpaceBytes: space,
                totalSpaceBytes: totalSpace
            )
            
            return disk
            
        } catch {
            print("Error retrieving resource values for \(volume): \(error.localizedDescription)")
            
            return nil
        }
    }
}
