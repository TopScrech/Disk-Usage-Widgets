import ScrechKit

struct StorageGaugeView: View {
    let snapshot: StorageSnapshot

    var body: some View {
        ZStack {
            Circle()
                .stroke(.quaternary, lineWidth: 20)

            Circle()
                .trim(from: 0, to: snapshot.usedFraction)
                .stroke(
                    AngularGradient(
                        colors: [.blue, .indigo, .blue],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))

            VStack {
                Text(snapshot.usedFraction, format: .percent.precision(.fractionLength(0)))
                    .largeTitle(.bold)
                    .numericTransition(snapshot.usedFraction)

                Text("Used")
                    .secondary()
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .maxFrame(260)
        .padding()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Storage used")
        .accessibilityValue(
            Text(snapshot.usedFraction, format: .percent.precision(.fractionLength(0)))
        )
    }
}

#Preview {
    StorageGaugeView(snapshot: .preview)
        .padding()
}
