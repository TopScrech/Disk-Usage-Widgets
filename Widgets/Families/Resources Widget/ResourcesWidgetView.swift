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
            
            Text(entry.state.capitalized)
                .caption2()
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.quaternary, in: .capsule)
        }
    }
    
    private var usage: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let usage = entry.usage {
                Gauge(value: usage.cpu / 100) {
                    Text("CPU")
                } currentValueLabel: {
                    Text("\(usage.cpu, specifier: "%.0f")%")
                }
                
                Gauge(value: min(usage.memory / 64, 1)) {
                    Text("RAM1")
                } currentValueLabel: {
                    Text("\(usage.memory, specifier: "%.0f") GB")
                }
                
                Gauge(value: min(usage.disk / 512, 1)) {
                    Text("Disk")
                } currentValueLabel: {
                    Text("\(usage.disk, specifier: "%.0f") GB")
                }
            } else {
                Text("No usage yet")
                    .caption2()
                    .secondary()
            }
        }
    }
}

#Preview(as: .systemMedium) {
    ResourcesWidget()
} timeline: {
    ResourcesUsageEntry(
        date: .now,
        name: "Preview Disk",
        id: "disk-preview",
        state: "idle",
        usage: .init(memory: 18, cpu: 36, disk: 240)
    )
}
