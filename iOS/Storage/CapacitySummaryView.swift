import ScrechKit

struct CapacitySummaryView: View {
    private let snapshot: StorageSnapshot
    
    init(_ snapshot: StorageSnapshot) {
        self.snapshot = snapshot
    }
    
    var body: some View {
        VStack {
            CapacityMetricView(
                title: "Available",
                bytes: snapshot.availableBytes,
                systemImage: "checkmark.circle.fill",
                color: .green
            )
            
            CapacityMetricView(
                title: "Used",
                bytes: snapshot.usedBytes,
                systemImage: "internaldrive.fill",
                color: .blue
            )
            
            CapacityMetricView(
                title: "Total",
                bytes: snapshot.totalBytes,
                systemImage: "externaldrive.fill",
                color: .secondary
            )
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CapacitySummaryView(.preview)
        .padding()
}
