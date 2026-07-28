import ScrechKit

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase

    @State private var vm = StorageVM()

    var body: some View {
        NavigationStack {
            StorageOverviewView()
                .environment(vm)
                .navigationTitle("Disk Usage")
        }
        .task {
            vm.refresh()
        }
        .onChange(of: scenePhase) { _, newPhase in
            guard newPhase == .active else { return }
            vm.refresh()
        }
    }
}

#Preview {
    ContentView()
}
