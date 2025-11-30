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
                    .font(.headline)
                Text("Edit the widget and pick a volume")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            } else {
                header
                usage
                
                Text(entry.date, style: .time)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                
                Button("Refresh", intent: RefreshIntent())
                    .font(.caption)
            }
        }
        .padding()
        .containerBackground(for: .widget) {}
    }
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(entry.name)
                    .font(.headline)
                Text(entry.id)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(entry.state.capitalized)
                .font(.caption)
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
                    .font(.caption)
                    .foregroundStyle(.secondary)
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
