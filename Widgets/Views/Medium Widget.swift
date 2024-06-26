import SwiftUI
import WidgetKit

struct MediumWidgetView: View {
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
    
    private var buildNumber: String {
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            buildNumber
        } else {
            "Unknown"
        }
    }
    
    var body: some View {
        HStack {
            if let disk {
                Graph(
                    disk,
                    innerRadius: 40,
                    angularInset: 4,
                    cornerRadius: 5
                )
            }
            
            VStack {
                Text(disk?.name ?? "Unknown")
                    .title3()
                    .semibold()
                    .rounded()
                    .lineLimit(1)
                
                HStack {
                    Image(systemName: "externaldrive")
                    
                    Text(Date(), format: .dateTime.hour().minute())
                    
                    if entry.configuration.showBuildNumber {
                        Text("B\(buildNumber)")
                    }
                    
                    //                    Button {
                    //
                    //                    } label: {
                    //                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                    //                    }
                    //                    .buttonStyle(.plain)
                }
                .footnote()
                .foregroundStyle(.secondary)
                
                Spacer()
                
                Button(intent: RefreshIntent()) {
                    Text("Update")
                        .caption2()
                }
                
                Spacer()
                
                HStack(spacing: 2) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Available") // Available
                        Text("Used")     // Used
                        Text("Total")   // Total
                    }
                    .foregroundStyle(.secondary)
                    .frame(width: 70)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(available) // Available
                        Text(used)     // Used
                        Text(total)   // Total
                    }
                    .bold()
                    .frame(width: 60)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(availablePercentage) // Available
                        Text(usedPercentage)     // Used
                        Text("100 %")           // Total
                    }
                    .bold()
                    .frame(width: 50)
                }
                .lineLimit(1)
                .caption2()
            }
        }
    }
}

#Preview(as: .systemMedium) {
    DiskUsageWidget()
} timeline: {
    SimpleEntry(
        date: Date(),
        configuration: .init(),
        disks: [Preview.disk]
    )
}
