import ScrechKit

struct CapacitySummaryView: View {
    let snapshot: StorageSnapshot

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
    CapacitySummaryView(snapshot: .preview)
        .padding()
}
