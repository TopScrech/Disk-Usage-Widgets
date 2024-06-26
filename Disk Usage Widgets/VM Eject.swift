#if canImport(DiskArbitration)

import Foundation
import DiskArbitration

extension VM {
    func ejectDisk(_ diskPath: String) {
        guard let session = DASessionCreate(kCFAllocatorDefault) else {
            print("Failed to create DASession")
            return
        }
        
        let volumePath = diskPath as CFString
        
        guard let diskURL = URL(string: volumePath as String),
              let disk = DADiskCreateFromVolumePath(kCFAllocatorDefault, session, diskURL as CFURL)
        else {
            print("Failed to create disk reference")
            return
        }
        DADiskEject(disk, DADiskEjectOptions(kDADiskEjectOptionDefault), { disk, status, context in
            if status as! Int == kDAReturnSuccess {
                print("Disk ejected successfully")
            } else {
                print("Failed to eject disk")
            }
        }, nil)
    }
}

#endif
