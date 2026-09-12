import SwiftUI
import WidgetKit

struct DiskUsageWidgetView: View {
    @Environment(\.widgetFamily) private var family
    
    private var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    var body: some View {
        if entry.selectedDiskNotFound {
            SelectedDiskNotFoundView()
        } else {
            switch family {
            case .systemSmall:
                SmallWidgetView(entry)
                
            case .systemMedium:
                MediumWidgetView(entry)
                
            case .systemLarge:
                LargeWidgetView(entry)
                
            case .systemExtraLarge:
                ExtraLargeWidgetView(entry)
                
            default:
                Text("Error")
            }
        }
    }
}

private struct SelectedDiskNotFoundView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .fontSize(22)
                .semibold()
                .foregroundStyle(.yellow)
            
            Text("Selected disk not found")
                .multilineTextAlignment(.center)
                .bold()
                .secondary()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Button(intent: RefreshIntent()) {
                Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                    .caption2()
            }
            .clipShape(.circle)
            .offset(x: -12, y: -8)
        }
    }
}
