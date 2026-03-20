import Foundation

extension FileManager {
    func volumeUsedDiskSpace(_ url: URL) throws -> Int {
        let totalCapacity = try volumeTotalDiskSpace(url)
        let freeCapacity = try volumeFreeDiskSpace(url)
        
        return totalCapacity - freeCapacity
    }
    
    func volumeFreeDiskSpace(_ url: URL) throws -> Int {
        let values = try url.resourceValues(forKeys: [.volumeAvailableCapacityKey])
        
        guard let capacity = values.volumeAvailableCapacity else {
            throw NSError(
                domain: "FileManager+VolumeSize",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Could not get free capacity"
                ]
            )
        }
        
        return Int(capacity)
    }
    
    func volumeTotalDiskSpace(_ url: URL) throws -> Int {
        let values = try url.resourceValues(forKeys: [.volumeTotalCapacityKey])
        
        guard let totalCapacity = values.volumeTotalCapacity else {
            throw NSError(
                domain: "FileManager+VolumeSize",
                code: 2,
                userInfo: [
                    NSLocalizedDescriptionKey: "Could not get total capacity"
                ]
            )
        }
        
        return totalCapacity
    }
}
