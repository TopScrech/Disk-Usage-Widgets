import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    private var disk: DiskEntry? {
        entry.disks.first
    }
    
    private var name: String {
        disk?.name ?? "Unknown"
    }
    
    var body: some View {
        VStack {
            if let disk {
                Graph(
                    disk,
                    innerRadius: 40,
                    angularInset: 4,
                    cornerRadius: 3
                )
            }
            
            if entry.config.showDiskName {
                HStack {
                    Label(name, systemImage: disk?.icon ?? "")
                        .bold()
                        .secondary()
                        .padding(.top, 5)
                        .lineLimit(1)
                }
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
        .overlay(alignment: .topTrailing) {
            VStack(alignment: .trailing) {
                if entry.config.showRefreshTime {
                    Text(entry.date, format: .dateTime.hour().minute().second())
                }
                
                if entry.config.showBuildNumber {
                    Text("B\(Utils.buildNumber)")
                }
            }
            .caption2()
            .tertiary()
            .offset(x: 5, y: -5)
        }
    }
}

#Preview(as: .systemSmall) {
    DiskUsageWidget()
} timeline: {
    SimpleEntry(
        date: Date(),
        config: .init(),
        disks: [Preview.disk]
    )
}
