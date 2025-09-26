import SwiftUI

struct DiskEjectableSection: View {
    private let disk: DiskEntry
    
    init(_ disk: DiskEntry) {
        self.disk = disk
    }
    
    var body: some View {
#if DEBUG
        if disk.isEjectable {
            Button("Eject") {
                if let url = disk.url?.path {
                    ejectDisk(url)
                } else {
                    print("Path not found")
                }
            }
        }
#else
        Text(disk.isEjectable ? "Yes" : "No")
#endif
    }
    
#if DEBUG
    // Doesn't work in sandbox
    func ejectDisk(_ diskPath: String) {
        let process = Process()
        process.launchPath = "/usr/sbin/diskutil"
        process.arguments = ["eject", diskPath]
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
        process.terminationHandler = { proc in
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            
            if let output = String(data: data, encoding: .utf8) {
                print("diskutil output:", output)
            }
            
            if proc.terminationStatus == 0 {
                print("Disk ejected successfully")
            } else {
                print("⛔️ Failed to eject disk, exit code:", proc.terminationStatus)
            }
        }
        
        do {
            try process.run()
        } catch {
            print("⛔️ Failed to run diskutil:", error)
        }
    }
#endif
}

#Preview {
    DiskEjectableSection(Utils.previewDisk)
        .darkSchemePreferred()
}
