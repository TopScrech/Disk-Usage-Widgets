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
            
            HStack {
                Label(name, systemImage: disk?.icon ?? "")
                    .bold()
                    .foregroundStyle(.secondary)
                    .padding(.top, 5)
                    .lineLimit(1)
            }
        }
        .overlay(alignment: .topLeading) {
            if entry.configuration.showRefreshButton {
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
                if entry.configuration.showRefreshTime {
                    Text(entry.date, format: .dateTime.hour().minute())
                }
                
                if entry.configuration.showBuildNumber {
                    Text("B\(Utilities.buildNumber)")
                }
            }
            .caption2()
            .foregroundStyle(.tertiary)
            .offset(x: 5, y: -5)
        }
    }
}

#Preview(as: .systemSmall) {
    DiskUsageWidget()
} timeline: {
    SimpleEntry(
        date: Date(),
        configuration: .init(),
        disks: [Utilities.previewDisk]
    )
}
