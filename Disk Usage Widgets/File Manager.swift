import Foundation

extension FileManager {
    func volumeFreeDiskSpace(_ url: URL) throws -> Int64 {
        do {
            let values = try url.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
            
            if let capacity = values.volumeAvailableCapacityForImportantUsage {
                return capacity
            }
        } catch let error {
            print("FileManager+DirectorySize: Problem while requesting volume capacity: \(error)")
            
            //            log.warning("FileManager+DirectorySize: Problem while requesting volume capacity: \(error)")
        }
        
        return 0
    }
    
    func volumeTotalDiskSpace(_ url: URL) throws -> Int {
        do {
            let values = try url.resourceValues(forKeys: [.volumeTotalCapacityKey])
            
            if let totalCapacity = values.volumeTotalCapacity {
                return totalCapacity
            }
        } catch let error {
            print("FileManager+VolumeSize: Problem while requesting volume total capacity: \(error)")
        }
        
        return 0
    }
    
    func volumeUsedDiskSpace(_ url: URL) throws -> Int64 {
        do {
            // Fetch total capacity
            let totalCapacity = try self.volumeTotalDiskSpace(url)
            
            // Fetch free capacity
            let freeCapacity = try self.volumeFreeDiskSpace(url)
            
            // Calculate used capacity
            let usedCapacity = Int64(totalCapacity) - freeCapacity
            
            return usedCapacity
        } catch let error {
            print("FileManager+VolumeSize: Error while calculating used disk space: \(error)")
            throw error
        }
    }
}
