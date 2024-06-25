import SwiftUI
import Charts

struct Graph: View {
    let innerRadius: MarkDimension
    let angularInset: CGFloat
    let cornerRadius: CGFloat
    let showOverlay: Bool
    
    init(innerRadius: MarkDimension, angularInset: CGFloat, cornerRadius: CGFloat, showOverlay: Bool = true) {
        self.innerRadius = innerRadius
        self.angularInset = angularInset
        self.cornerRadius = cornerRadius
        self.showOverlay = showOverlay
    }
    
    let data: [DiskEntry] = [Preview.disk]
    
    var body: some View {
        VStack {
            Chart(data) { disk in
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
                        
                        Text(data.first?.freeSpace ?? "-")
                            .bold()
                    }
                    .rounded()
                }
            }
        }
    }
}
