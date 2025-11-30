import SwiftUI
import WidgetKit

struct ResourcesWidgetView: View {
    private let entry: ResourcesUsageEntry
    
    init(_ entry: ResourcesUsageEntry) {
        self.entry = entry
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if entry.id.isEmpty {
                Text("Choose a disk")
                    .title3()
                
                Text("Edit the widget and pick a volume")
                    .caption2()
                    .secondary()
            } else {
                header
                usage
                
                Text(entry.date, style: .time)
                    .caption2()
                    .secondary()
                
                Button("Refresh", intent: RefreshIntent())
                    .caption2()
            }
        }
        .padding()
        .containerBackground(for: .widget) {}
    }
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(entry.name)
                    .title3()
                
                Text(entry.id)
                    .caption2()
                    .secondary()
            }
            
            Spacer()
        }
    }
    
    private var usage: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("No")
                .caption2()
                .secondary()
        }
    }
}

#Preview(as: .systemMedium) {
    ResourcesWidget()
} timeline: {
    ResourcesUsageEntry(
        date: .now,
        name: "Preview Disk",
        id: "disk-preview"
    )
}
