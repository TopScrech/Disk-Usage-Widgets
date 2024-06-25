import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    var body: some View {
        Graph(innerRadius: 40, angularInset: 4, cornerRadius: 3)
        
        Label("Preview SSD", systemImage: "externaldrive")
            .bold()
            .footnote()
            .foregroundStyle(.secondary)
            .padding(.top, 5)
    }
}

struct SmallWidget: Widget {
    let kind = "Widgets"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(macOS 14, *) {
                SmallWidgetView(entry)
                    .containerBackground(.ultraThickMaterial, for: .widget)
            } else {
                SmallWidgetView(entry)
                    .padding()
                    .background()
            }
        }
        //        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Small Widget")
        .description("This is an example widget")
    }
}

#Preview(as: .systemSmall) {
    SmallWidget()
} timeline: {
    SimpleEntry(date: Date(), emoji: "")
}
