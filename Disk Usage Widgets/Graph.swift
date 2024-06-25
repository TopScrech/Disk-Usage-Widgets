import SwiftUI
import Charts

struct Graph: View {
    let data: [DiskEntry] = [.init(url: URL(string: ""), name: "Preview", localizedName: "Превью", freeSpaceBytes: 500000, totalSpaceBytes: 1000000)]
    
    var body: some View {
        VStack {
            Chart(data) { disk in
                SectorMark(angle: .value("Amount", disk.freeSpaceBytes), innerRadius: 100, angularInset: 4)
                    .cornerRadius(5)
                    .foregroundStyle(by: .value("Category", disk.freeSpace))
                
                SectorMark(angle: .value("Total", disk.totalSpaceBytes), innerRadius: 100, angularInset: 4)
                    .cornerRadius(5)
                    .foregroundStyle(by: .value("Category", disk.totalSpace))
            }
            .chartLegend(.hidden)
            .overlay {
                VStack {
                    Text("Availible")
                    
                    Text(data.first?.freeSpace ?? "-")
                        .bold()
                }
            }
            
            Text(data.first?.localizedName ?? "-")
                .title3()
                .padding(.top, 5)
        }
    }
}

#Preview {
    Graph()
        .padding(40)
}
