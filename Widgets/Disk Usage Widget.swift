import SwiftUI
import WidgetKit

struct DiskUsageWidgetView: View {
    @Environment(\.widgetFamily) private var family
    
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry)
            
        case .systemMedium:
            MediumWidgetView(entry)
            
#if DEBUG
        case .systemLarge:
            LargeWidgetView(entry)
            
        case .systemExtraLarge:
            ExtraLargeWidgetView(entry)
#endif
            
        default:
            Text("Error")
        }
    }
}

struct DiskUsageWidget: Widget {
    private let kind = "Disk Usage Widgets"
    private let provider = Provider()
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: provider
        ) { entry in
            
#warning("Enable .systemExtraLarge")
            
            DiskUsageWidgetView(entry)
                .containerBackground(.ultraThinMaterial, for: .widget)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge/*, .systemExtraLarge*/])
        .configurationDisplayName("Disk Usage")
        .description("This is an example")
    }
}
