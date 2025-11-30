import SwiftUI

struct DiskFreeSpaceSection: View {
    private let disk: DiskEntry
    
    init(_ disk: DiskEntry) {
        self.disk = disk
    }
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .trailing, spacing: 0) {
                Text(disk.freeSpace)
                
                Text(disk.freeSpacePercentage)
                    .tertiary()
            }
            
            Spacer()
            
            Gauge(value: Double(disk.freeSpaceBytes), in: 0...Double(disk.totalSpaceBytes)) {}
                .gaugeStyle(.accessoryCircularCapacity)
                .scaleEffect(0.6)
                .tint(.green)
        }
    }
}

#Preview {
    DiskFreeSpaceSection(Preview.disk)
        .darkSchemePreferred()
}
