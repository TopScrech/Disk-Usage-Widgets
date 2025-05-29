import SwiftUI
import WidgetKit

struct ExtraLargeWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    private var disk: DiskEntry? {
        entry.disks.first
    }
    
    private var available: String {
        disk?.freeSpace ?? "-"
    }
    
    private var total: String {
        disk?.totalSpace ?? "-"
    }
    
    private var used: String {
        disk?.usedSpace ?? "-"
    }
    
    private var availablePercentage: String {
        disk?.freeSpacePercentage ?? "-"
    }
    
    private var usedPercentage: String {
        disk?.usedSpacePercentage ?? "-"
    }
    
    private var icon: String {
        disk?.icon ?? ""
    }
    
    var body: some View {
        HStack {
            if let disk {
                ExtraLargeGraph(
                    disk,
                    innerRadius: 100,
                    angularInset: 4,
                    cornerRadius: 5
                )
            }
            
            VStack {
                Label(disk?.name ?? "Unknown", systemImage: icon)
                    .largeTitle()
                    .semibold()
                    .rounded()
                    .lineLimit(1)
                
                HStack {
                    if entry.configuration.showRefreshTime {
                        Text(Date(), format: .dateTime.hour().minute().second())
                    }
                    
                    if entry.configuration.showBuildNumber {
                        Text("B\(Utils.buildNumber)")
                    }
                }
                .tertiary()
                
                Spacer()
                
                HStack(spacing: 2) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Available")     // Available
                        Text("Used")         // Used
                        
                        if entry.configuration.showTotalSpace {
                            Text("Total") // Total
                        }
                    }
                    .secondary()
                    .frame(width: 80)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(available)     // Available
                        Text(used)         // Used
                        
                        if entry.configuration.showTotalSpace {
                            Text(total) // Total
                        }
                    }
                    .bold()
                    .frame(width: 80)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(availablePercentage) // Available
                        Text(usedPercentage)     // Used
                        
                        if entry.configuration.showTotalSpace {
                            Text("100 %")     // Total
                        }
                    }
                    .bold()
                    .frame(width: 80)
                }
                .lineLimit(1)
                .title3()
                //                .footnote()
            }
        }
        //        .largeTitle()
        .overlay(alignment: .topLeading) {
            if entry.configuration.showRefreshButton {
                Button(intent: RefreshIntent()) {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                }
                .clipShape(.circle)
                .offset(x: -12, y: -8)
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
        disks: [Utils.previewDisk]
    )
}
