import SwiftUI
import WidgetKit

struct DiskUsageWidget: Widget {
    private let kind = "Disk Usage Widgets"
    private let provider = Provider()
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigAppIntent.self, provider: provider) {
            DiskUsageWidgetView($0)
                .containerBackground(.ultraThinMaterial, for: .widget)
        }
        .configurationDisplayName("Disk Usage")
        .description("Widget configuration")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
    }
}
