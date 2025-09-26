import SwiftUI

struct DiskTypeSection: View {
    private let disk: DiskEntry
    
    init(_ disk: DiskEntry) {
        self.disk = disk
    }
    
    var body: some View {
        if disk.isEncrypted {
            Text("\(disk.type) 􀞚")
                .help("Encrypted")
        } else {
            Text(disk.type)
        }
    }
}

#Preview {
    DiskTypeSection(Utils.previewDisk)
        .darkSchemePreferred()
}
