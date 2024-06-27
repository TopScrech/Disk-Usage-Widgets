import SwiftUI
import WidgetKit

struct LargeWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    private var disks: [DiskEntry] {
        entry.disks.prefix(3).map {
            $0
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height * 0.33
            
            VStack(spacing: 0) {
                Group {
                    if disks.count > 0 {
                        LargeDiskCard(entry, disk: disks[0])
                            .frame(height: height)
                            .overlay(alignment: .topTrailing) {
                                if !entry.configuration.showRefreshButton {
                                    Button(intent: RefreshIntent()) {
                                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                                            .caption2()
                                    }
                                    .clipShape(.circle)
                                    .offset(x: 12, y: -8)
                                }
                            }
                    }
                    
                    Divider()
                        .frame(height: 0)
                    
                    if disks.count > 1 {
                        LargeDiskCard(entry, disk: disks[1])
                    }
                    
                    Divider()
                        .frame(height: 0)
                    
                    if disks.count > 2 {
                        LargeDiskCard(entry, disk: disks[2])
                            .frame(height: height)
                    }
                }
            }
        }
    }
}

fileprivate struct LargeDiskCard: View {
    private let entry: SimpleEntry
    private let disk: DiskEntry
    
    init(_ entry: SimpleEntry, disk: DiskEntry) {
        self.entry = entry
        self.disk = disk
    }
    
    private var availablePercentage: String {
        disk.freeSpacePercentage
    }
    
    private var usedPercentage: String {
        disk.usedSpacePercentage
    }
    
    var body: some View {
        HStack {
            Graph(
                disk,
                innerRadius: 40,
                angularInset: 4,
                cornerRadius: 3
            )
            .frame(width: 100)
            
            Spacer()
            
            VStack {
                Label(disk.name, systemImage: disk.icon)
                    .title3()
                    .semibold()
                    .rounded()
                    .lineLimit(1)
                
                HStack {
                    if entry.configuration.showRefreshTime {
                        Text(Date(), format: .dateTime.hour().minute())
                    }
                    
                    if entry.configuration.showBuildNumber {
                        Text("B\(Utilities.buildNumber)")
                    }
                }
                .footnote()
                .foregroundStyle(.tertiary)
                
                HStack(spacing: 2) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Available") // Available
                        Text("Used")     // Used
                        Text("Total")   // Total
                    }
                    .foregroundStyle(.secondary)
                    .frame(width: 80)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(disk.freeSpace)    // Available
                        Text(disk.usedSpace)   // Used
                        Text(disk.totalSpace) // Total
                    }
                    .bold()
                    .frame(width: 70)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(availablePercentage) // Available
                        Text(usedPercentage)     // Used
                        Text("100 %")           // Total
                    }
                    .bold()
                    .frame(width: 70)
                }
                .lineLimit(1)
                .footnote()
                .padding(.top, 5)
            }
        }
    }
}

#Preview(as: .systemExtraLarge) {
    DiskUsageWidget()
} timeline: {
    SimpleEntry(
        date: Date(),
        configuration: .init(),
        disks: Utilities.previewDisks
    )
}
