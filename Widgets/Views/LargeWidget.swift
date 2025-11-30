import SwiftUI
import WidgetKit

struct LargeWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    private var disk: DiskEntry? {
        entry.disk
    }
    
    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height * 0.60
            
            Group {
                if let disk {
                    LargeDiskCard(entry, disk: disk)
                        .frame(height: height)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    MissingDiskView(
                        isSelectedDiskMissing: entry.isSelectedDiskMissing
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .overlay(alignment: .top) {
            HStack(spacing: 5) {
                if entry.config.showRefreshTime {
                    Text(Date(), format: .dateTime.hour().minute().second())
                }
                
                if entry.config.showBuildNumber {
                    Text("B\(Utils.buildNumber)")
                }
            }
            .footnote()
            .tertiary()
            .offset(y: -10)
        }
        .overlay(alignment: .topTrailing) {
            if entry.config.showRefreshButton {
                Button(intent: RefreshIntent()) {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                        .caption2()
                }
                .clipShape(.circle)
                .offset(x: 12, y: -8)
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
                innerRadius: 35,
                angularInset: 4,
                cornerRadius: 3
            )
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
        config: .init(),
        disk: Preview.disk,
        isSelectedDiskMissing: false
    )
}
