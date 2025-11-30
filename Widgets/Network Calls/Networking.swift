import Foundation

struct Networking {
    static func fetchDisks() async -> [Asset] {
        let volumes = FileManager.default.mountedVolumeURLs(
            includingResourceValuesForKeys: [.volumeNameKey, .volumeLocalizedNameKey],
            options: .skipHiddenVolumes
        ) ?? []
        
        let disks = volumes.compactMap { volume -> Asset? in
            let values = try? volume.resourceValues(forKeys: [.volumeNameKey, .volumeLocalizedNameKey])
            
            guard let name = values?.volumeLocalizedName ?? values?.volumeName else {
                return nil
            }
            
            return Asset(id: volume.path, name: name)
        }
        
        if disks.isEmpty {
            return [
                Asset(id: "sample-disk-a", name: "Sample Disk A"),
                Asset(id: "sample-disk-b", name: "Sample Disk B")
            ]
        }
        
        return disks
    }
}
