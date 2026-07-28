import ScrechKit
import UniformTypeIdentifiers

struct ExternalDrivesView: View {
    @Environment(StorageVM.self) private var vm
    
    @State private var isImporterPresented = false
    @State private var addHapticTrigger = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("External Drives")
                    .headline()
                
                Spacer()
                
                Button("Add Drive", systemImage: "externaldrive.badge.plus") {
                    addHapticTrigger.toggle()
                    isImporterPresented = true
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.bordered)
                .hapticOn(addHapticTrigger, as: .selection)
            }
            
            if vm.externalDrives.isEmpty {
                Label(
                    vm.hasSavedExternalDrives
                    ? "Saved drives are disconnected"
                    : "No external drives added",
                    systemImage: "externaldrive.badge.questionmark"
                )
                .secondary()
                
                Text(
                    vm.hasSavedExternalDrives
                    ? "Reconnect a saved drive"
                    : "Choose the drive itself or any folder on it to grant access"
                )
                .footnote()
                .secondary()
                .transition(.opacity)
            } else {
                ForEach(vm.externalDrives) { drive in
                    ExternalDriveView(
                        drive: drive,
                        forgetAction: {
                            vm.forgetExternalDrive(id: drive.id)
                        }
                    )
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            
            if let errorMessage = vm.externalDriveErrorMessage {
                Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                    .footnote()
                    .foregroundStyle(.orange)
            }
        }
        .padding()
        .background(.background, in: .rect(cornerRadius: 20))
        .animation(.snappy, value: vm.externalDrives.map(\.id))
        .fileImporter(
            isPresented: $isImporterPresented,
            allowedContentTypes: [.folder]
        ) {
            vm.addExternalDrive(from: $0)
        }
    }
}

#Preview {
    ExternalDrivesView()
        .environment(StorageVM())
        .padding()
}
