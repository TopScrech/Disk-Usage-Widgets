import SwiftUI

struct LargeDiskCard: View {
    private let entry: SimpleEntry
    private let disk: DiskEntry
    
    init(_ entry: SimpleEntry, disk: DiskEntry) {
        self.entry = entry
        self.disk = disk
    }
    
    var body: some View {
        HStack {
            Graph(disk, innerRadius: 35, angularInset: 4, cornerRadius: 3)
                .frame(width: 100)
            
            Spacer()
            
            VStack {
                if entry.config.showDiskName {
                    Label(disk.name, systemImage: disk.icon)
                        .title3()
                        .semibold()
                        .rounded()
                        .lineLimit(1)
                }
                
                HStack(spacing: 2) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Available") // Available
                        Text("Used")     // Used
                        Text("Total")   // Total
                    }
                    .secondary()
                    .frame(width: 80)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(disk.freeSpace)    // Available
                        Text(disk.usedSpace)   // Used
                        Text(disk.totalSpace) // Total
                    }
                    .bold()
                    .monospacedDigit()
                    .frame(width: 70)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(disk.freeSpacePercentage)  // Available
                        Text(disk.usedSpacePercentage) // Used
                        Text("100 %")                 // Total
                    }
                    .bold()
                    .monospacedDigit()
                    .frame(width: 70)
                }
                .lineLimit(1)
                .footnote()
                .padding(.top, 5)
            }
        }
    }
}
