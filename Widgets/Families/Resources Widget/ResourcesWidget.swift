import SwiftUI
import WidgetKit

struct ResourcesWidget: Widget {
    private let kind = "Dynamic Disk Widget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: CryptoPriceConfigurationIntent.self, provider: ResourcesTimelineProvider()) {
            ResourcesWidgetView($0)
        }
        .configurationDisplayName("Dynamic Disk Test")
        .description("Pick a disk dynamically and view randomized usage")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemMedium) {
    ResourcesWidget()
} timeline: {
    ResourcesUsageEntry(
        date: .now,
        name: "Preview Disk",
        id: "disk-preview",
        state: "running",
        usage: .init(memory: 16, cpu: 42, disk: 180)
    )
}
