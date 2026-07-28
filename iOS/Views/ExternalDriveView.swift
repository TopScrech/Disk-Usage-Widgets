import ScrechKit

struct ExternalDriveView: View {
    let drive: ExternalDriveSnapshot
    let forgetAction: () -> Void

    @State private var forgetHapticTrigger = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label(drive.storage.name, systemImage: "externaldrive.connected.to.line.below")
                    .headline()

                Spacer()

                Button("Forget Drive", systemImage: "xmark") {
                    forgetHapticTrigger.toggle()
                    forgetAction()
                }
                    .labelStyle(.iconOnly)
                    .buttonStyle(.borderless)
                    .hapticOn(forgetHapticTrigger, as: .warning)
            }

            ProgressView(value: drive.storage.usedFraction)
                .tint(.blue)
                .accessibilityLabel("Used capacity")

            HStack {
                Text("\(drive.storage.availableBytes, format: .byteCount(style: .file)) available")

                Spacer()

                Text("\(drive.storage.totalBytes, format: .byteCount(style: .file)) total")
            }
            .footnote()
            .secondary()

            Text(drive.storage.fileSystem)
                .caption()
                .secondary()
        }
        .padding()
        .background(.background, in: .rect(cornerRadius: 20))
    }
}

#Preview {
    ExternalDriveView(
        drive: ExternalDriveSnapshot(id: UUID(), storage: .preview),
        forgetAction: {}
    )
    .padding()
}
