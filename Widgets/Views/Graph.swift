import SwiftUI
import Charts

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
                .foregroundStyle(by: .value("Category", disk.freeSpace))
                
                SectorMark(
                    angle: .value("Total", disk.totalSpaceBytes),
                    innerRadius: innerRadius,
                    angularInset: angularInset
                )
                .cornerRadius(cornerRadius)
                .foregroundStyle(by: .value("Category", disk.totalSpace))
            }
            .chartLegend(.hidden)
            .overlay {
                if showOverlay {
                    VStack {
                        Text("Available")
                            .footnote()
                        
                        Text(disk.freeSpace)
                            .bold()
                    }
                    .rounded()
                }
            }
        }
    }
}
