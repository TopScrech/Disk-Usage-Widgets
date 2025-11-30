import SwiftUI
import WidgetKit

struct MediumWidgetView: View {
    private let entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    private var disk: DiskEntry? {
        entry.disks.first
    }
    
    var body: some View {
        HStack {
            if let disk {
                Graph(disk, innerRadius: 40, angularInset: 4, cornerRadius: 5)
            }
            
            VStack {
                if entry.config.showDiskName {
                    Label(disk?.name ?? "Unknown", systemImage: disk?.icon ?? "")
                        .title3()
                        .semibold()
                        .rounded()
                        .lineLimit(1)
                }
                
                HStack {
                    if entry.config.showRefreshTime {
                        Text(Date(), format: .dateTime.hour().minute().second())
                    }
                    
                    if entry.config.showBuildNumber {
                        Text("B\(Utils.buildNumber)")
                    }
                }
                .footnote()
                .tertiary()
                
                Spacer()
                
                HStack(spacing: 2) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Available") // Available
                        Text("Used")     // Used
                        
                        if entry.config.showTotalSpace {
                            Text("Total") // Total
                        }
                    }
                    .secondary()
                    .frame(width: 55)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(disk?.freeSpace ?? "-")  // Available
                        Text(disk?.usedSpace ?? "-") // Used
                        
                        if entry.config.showTotalSpace {
                            Text(disk?.totalSpace ?? "-") // Total
                        }
                    }
                    .bold()
                    .frame(width: 60)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(disk?.freeSpacePercentage ?? "-")  // Available
                        Text(disk?.usedSpacePercentage ?? "-") // Used
                        
                        if entry.config.showTotalSpace {
                            Text("100 %")     // Total
                        }
                    }
                    .bold()
                    .frame(width: 60)
                }
                .lineLimit(1)
                .footnote()
            }
        }
        .overlay(alignment: .topLeading) {
            if entry.config.showRefreshButton {
                Button(intent: RefreshIntent()) {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                        .caption2()
                }
                .clipShape(.circle)
                .offset(x: -12, y: -8)
            }
        }
    }
}

#Preview(as: .systemMedium) {
    DiskUsageWidget()
} timeline: {
    SimpleEntry(date: Date(), config: .init(), disks: [Preview.disk])
}
