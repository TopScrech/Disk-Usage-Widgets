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
            
        default:
            Text("Error")
        }
    }
}

struct DiskUsageWidget: Widget {
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
