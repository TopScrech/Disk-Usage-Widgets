import WidgetKit
import SwiftUI

struct MediumWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    @Environment(\.widgetFamily) private var family

    var body: some View {
        HStack {
            Graph(innerRadius: 40, angularInset: 4, cornerRadius: 5, showOverlay: false)
            
            VStack {
                Text("Preview SSD")
                    .title3()
                    .rounded()
                    .lineLimit(1)
                    .semibold()
                
                HStack {
                    Image(systemName: "externaldrive")
                    
                    Text(Date(), format: .dateTime.hour().minute())
                    switch family {
                    case .systemSmall:
                        Text("Small")
                        
                    case .systemMedium:
                        Text("Med")
                        
                    default:
                        Text("Error")
                    }

                    //                    Button {
                    //
                    //                    } label: {
                    //                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                    //                    }
                    //                    .buttonStyle(.plain)
                }
                .footnote()
                .foregroundStyle(.secondary)
                
                Spacer()
                
                HStack(spacing: 2) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Available")
                        Text("Used")
                        Text("Total")
                    }
                    .foregroundStyle(.secondary)
                    .frame(width: 70)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("3.0 TB")
                        Text("999.0 TB")
                        Text("0.7 TB")
                    }
                    .bold()
                    .frame(width: 60)
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("100 %")
                        Text("70 %")
                        Text("7 %")
                    }
                    .bold()
                    .frame(width: 50)
                }
                .lineLimit(1)
                .caption2()
            }
        }
        .containerBackground(.ultraThickMaterial, for: .widget)
    }
}

struct MediumWidget: Widget {
    let kind = "Medium Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(macOS 14, *) {
                MediumWidgetView(entry)
                    .containerBackground(.ultraThickMaterial, for: .widget)
            } else {
                MediumWidgetView(entry)
                    .padding()
                    .background()
            }
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Memium Widget")
        .description("This is an example widget")
    }
}

#Preview(as: .systemMedium) {
    MediumWidget()
} timeline: {
    SimpleEntry(date: Date(), emoji: "")
}
