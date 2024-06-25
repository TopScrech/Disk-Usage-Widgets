import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    var body: some View {
        VStack {
            Graph(
                innerRadius: 40,
                angularInset: 4,
                cornerRadius: 3
            )
            
            Label("Preview SSD", systemImage: "externaldrive")
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

struct SmallWidget: Widget {
    private let kind = "Widgets"
    private let provider = Provider()
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: provider) { entry in
            if #available(macOS 14, iOS 17, *) {
                SmallWidgetView(entry)
                    .containerBackground(.ultraThickMaterial, for: .widget)
            } else {
                SmallWidgetView(entry)
                    .padding()
                    .background()
            }
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Small Widget")
        .description("This is an example widget")
    }
}

struct SpaceUsageWidget: Widget {
    @Environment(\.widgetFamily) private var family
    
    private let kind = "Disk Usage Widgets"
    private let provider = Provider()
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: provider) { entry in
            DiskUsageWidgetView(entry)
                .containerBackground(.ultraThinMaterial, for: .widget)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Disk Usage")
        .description("This is an example")
    }
}

#Preview(as: .systemSmall) {
    SmallWidget()
} timeline: {
    SimpleEntry(date: Date(), emoji: "")
}
