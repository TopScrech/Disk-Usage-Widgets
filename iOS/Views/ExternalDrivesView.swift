import ScrechKit
import UniformTypeIdentifiers

struct ExternalDrivesView: View {
    @Environment(StorageVM.self) private var viewModel

    @State private var isImporterPresented = false
    @State private var addHapticTrigger = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("External Drives")
                    .headline()

                Spacer()

                Button(
                    "Add Drive",
                    systemImage: "externaldrive.badge.plus"
                ) {
                    addHapticTrigger.toggle()
                    isImporterPresented = true
                }
                .buttonStyle(.bordered)
                .hapticOn(addHapticTrigger, as: .selection)
            }

            if viewModel.externalDrives.isEmpty {
                Label(
                    viewModel.hasSavedExternalDrives
                        ? "Saved drives are disconnected"
                        : "No external drives added",
                    systemImage: "externaldrive.badge.questionmark"
                )
                .secondary()

                Text(
                    viewModel.hasSavedExternalDrives
                        ? "Reconnect a saved drive and pull to refresh"
                        : "Choose the drive itself or any folder on it to grant access"
                )
                .footnote()
                .secondary()
            } else {
                ForEach(viewModel.externalDrives) { drive in
                    ExternalDriveView(
                        drive: drive,
                        forgetAction: {
                            viewModel.forgetExternalDrive(id: drive.id)
                        }
                    )
                }
            }

            if let errorMessage = viewModel.externalDriveErrorMessage {
                Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                    .footnote()
                    .foregroundStyle(.orange)
            }
        }
        .padding()
        .background(.background, in: .rect(cornerRadius: 20))
        .fileImporter(
            isPresented: $isImporterPresented,
            allowedContentTypes: [.folder]
        ) {
            viewModel.addExternalDrive(from: $0)
        }
    }
}

#Preview {
    ExternalDrivesView()
        .environment(StorageVM())
        .padding()
}
