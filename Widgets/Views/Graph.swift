import SwiftUI
import Charts
import WidgetKit

struct Graph: View {
    let disk: DiskEntry
    let innerRadius: MarkDimension
    let angularInset: CGFloat
    let cornerRadius: CGFloat
    let showOverlay: Bool
    
    init(
        _ disk: DiskEntry,
        innerRadius: MarkDimension,
        angularInset: CGFloat,
        cornerRadius: CGFloat,
        showOverlay: Bool = true
    ) {
        self.disk = disk
        self.innerRadius = innerRadius
        self.angularInset = angularInset
        self.cornerRadius = cornerRadius
        self.showOverlay = showOverlay
    }
    
    var body: some View {
        VStack {
            Chart([disk]) { disk in
                SectorMark(
                    angle: .value("Amount", disk.freeSpaceBytes),
                    innerRadius: innerRadius,
                    angularInset: angularInset
                )
                .cornerRadius(cornerRadius)
                .foregroundStyle(.green.gradient)
                
                SectorMark(
                    angle: .value("Total", disk.totalSpaceBytes - Int(disk.freeSpaceBytes)),
                    innerRadius: innerRadius,
                    angularInset: angularInset
                )
                .foregroundStyle(.blue.gradient)
                .cornerRadius(cornerRadius)
            }
            .chartLegend(.hidden)
            .overlay {
                if showOverlay {
                    VStack(spacing: -2) {
                        Text("Available")
                            .footnote()
                        
                        Text(disk.freeSpace)
                            .frame(width: 70)
                            .lineLimit(1)
                            .scaledToFit()
                            .minimumScaleFactor(0.8)
                            .bold()
                    }
                    .rounded()
                }
            }
        }
    }
}

#Preview(as: .systemSmall) {
    DiskUsageWidget()
} timeline: {
    SimpleEntry(
        date: Date(),
        configuration: .init(),
        disks: [Preview.disk]
    )
}
