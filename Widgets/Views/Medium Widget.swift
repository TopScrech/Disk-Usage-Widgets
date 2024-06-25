import WidgetKit
import SwiftUI

struct MediumWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
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
    }
}

#Preview(as: .systemMedium) {
    DiskUsageWidget()
} timeline: {
    SimpleEntry(date: Date(), emoji: "")
}
