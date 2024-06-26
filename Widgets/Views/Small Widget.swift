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
    
    var body: some View {
        VStack {
            Graph(
                innerRadius: 40,
                angularInset: 4,
                cornerRadius: 3
            )
            
            Label(disk?.name ?? "Unknown", systemImage: "externaldrive")
                .bold()
                .footnote()
                .foregroundStyle(.secondary)
                .padding(.top, 5)
        }
        .overlay(alignment: .topTrailing) {
            Text(entry.date, format: .dateTime.hour().minute())
                .caption2()
                .foregroundStyle(.secondary)
                .offset(x: 5, y: -5)
        }
    }
}

#Preview(as: .systemSmall) {
    DiskUsageWidget()
} timeline: {
    SimpleEntry(date: Date(), emoji: "")
}
