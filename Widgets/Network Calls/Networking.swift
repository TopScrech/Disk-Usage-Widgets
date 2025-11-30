import Foundation

struct Networking {
    static func fetchServers() async -> [Asset] {
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
    
    static func fetchResourceUsage(_ id: String) async -> AssetDetails {
        let cpu = Double.random(in: 5...92)
        let memory = Double.random(in: 4...64)
        let disk = Double.random(in: 32...512)
        
        let states = ["running", "idle", "offline"]
        let state = states.randomElement() ?? "running"
        
        let usage = UsageAttributes(memory: memory, cpu: cpu, disk: disk)
        return AssetDetails(state: state, usage: usage)
    }
}
