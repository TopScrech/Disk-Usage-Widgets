import ScrechKit
import Appearance

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(StorageVM.self) private var vm
    
    @AppStorage("appearance") private var appearance: Appearance = .system
    @State private var clearHapticTrigger = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("General") {
                    AppearancePicker($appearance)
                        .foregroundStyle(.foreground)
                    
                    Button("Change language", systemImage: "globe") {
                        openSettings()
                    }
                    .foregroundStyle(.foreground)
                }
                
                Section("Saved Drives") {
                    if vm.savedExternalDrives.isEmpty {
                        ContentUnavailableView(
                            "No Saved Drives",
                            systemImage: "externaldrive.badge.questionmark",
                            description: Text("Drives added from the main page appear here")
                        )
                    } else {
                        ForEach(vm.savedExternalDrives) { drive in
                            SavedExternalDriveRow(
                                drive: drive,
                                isConnected: vm.isExternalDriveConnected(id: drive.id)
                            )
                            .swipeActions(edge: .trailing) {
                                Button(
                                    "Delete Drive",
                                    systemImage: "trash",
                                    role: .destructive
                                ) {
                                    vm.forgetExternalDrive(id: drive.id)
                                }
                            }
                        }
                    }
                }
                
                Section {
                    Button("Clear Saved Drives", systemImage: "trash") {
                        clearHapticTrigger.toggle()
                        vm.clearSavedExternalDrives()
                    }
                    .foregroundStyle(.red)
                    .disabled(vm.savedExternalDrives.isEmpty)
                    .hapticOn(clearHapticTrigger, as: .warning)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", systemImage: "checkmark") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(StorageVM())
}
