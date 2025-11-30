import SwiftUI
import WidgetKit

struct LargeWidgetView: View {
    private let entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    private var disks: [DiskEntry] {
        entry.disks.prefix(3).map { $0 }
    }
    
    var body: some View {
        GeometryReader {
            let height = $0.size.height * 0.30
            
            VStack(spacing: 5) {
                Group {
                    if disks.count > 0 {
                        LargeDiskCard(entry, disk: disks[0])
                            .frame(height: height)
                    }
                    
                    if disks.count > 1 {
                        Divider()
                            .frame(height: 0)
                            .padding(.vertical, 5)
                        
                        LargeDiskCard(entry, disk: disks[1])
                            .frame(height: height)
                    }
                    
                    if disks.count > 2 {
                        Divider()
                            .frame(height: 0)
                            .padding(.vertical, 5)
                        
                        LargeDiskCard(entry, disk: disks[2])
                            .frame(height: height)
                    }
                }
            }
        }
        .overlay(alignment: .top) {
            HStack(spacing: 5) {
                if entry.config.showRefreshTime {
                    Text(Date(), format: .dateTime.hour().minute().second())
                }
                
                if entry.config.showBuildNumber {
                    Text("B\(Utils.buildNumber)")
                }
            }
            .footnote()
            .tertiary()
            .offset(y: -10)
        }
        .overlay(alignment: .topTrailing) {
            if entry.config.showRefreshButton {
                Button(intent: RefreshIntent()) {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                        .caption2()
                }
                .clipShape(.circle)
                .offset(x: 12, y: -8)
            }
        }
    }
}

#Preview(as: .systemExtraLarge) {
    DiskUsageWidget()
} timeline: {
    SimpleEntry(date: Date(), config: .init(), disks: Preview.disks)
}
