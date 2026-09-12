import SwiftUI

struct DiskUsedSpaceSection: View {
    private let disk: DiskEntry
    
    init(_ disk: DiskEntry) {
        self.disk = disk
    }
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .trailing, spacing: 0) {
                Text(disk.usedSpace)
                
                Text(disk.usedSpacePercentage)
                    .tertiary()
            }
            .monospacedDigit()
            
            Spacer()
            
            Gauge(value: Double(disk.usedSpaceBytes), in: 0...Double(disk.totalSpaceBytes)) {}
                .gaugeStyle(.accessoryCircularCapacity)
                .scaleEffect(0.6)
                .tint(.red)
        }
    }
}

#Preview {
    DiskUsedSpaceSection(Preview.disk)
        .darkSchemePreferred()
}
