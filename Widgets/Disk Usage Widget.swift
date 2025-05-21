import SwiftUI
import WidgetKit

struct DiskUsageWidget: Widget {
    private let kind = "Disk Usage Widgets"
    private let provider = Provider()
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: provider
        ) { entry in
#warning("Enable .systemLarge")
#warning("Enable .systemExtraLarge")
            DiskUsageWidgetView(entry)
                .containerBackground(.ultraThinMaterial, for: .widget)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
        .configurationDisplayName("Disk Usage")
        .description("Widget configuration")
    }
}
