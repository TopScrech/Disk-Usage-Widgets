import ScrechKit

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var vm = StorageVM()
    @State private var isSettingsPresented = false
    @State private var settingsHapticTrigger = false
    
    var body: some View {
        NavigationStack {
            StorageOverview()
                .environment(vm)
                .navigationTitle("Disk Usage")
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Settings", systemImage: "gear") {
                            settingsHapticTrigger.toggle()
                            isSettingsPresented = true
                        }
                        .labelStyle(.iconOnly)
                        .hapticOn(settingsHapticTrigger, as: .selection)
                    }
                }
        }
        .task(id: scenePhase) {
            guard scenePhase == .active else { return }
            await vm.monitorStorage()
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
                .environment(vm)
        }
    }
}

#Preview {
    ContentView()
}
