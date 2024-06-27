import SwiftUI
import WidgetKit

struct ExtraLargeWidgetView: View {
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview(as: .systemExtraLarge) {
    DiskUsageWidget()
} timeline: {
    SimpleEntry(
        date: Date(),
        configuration: .init(),
        disks: [Utilities.previewDisk]
    )
}
