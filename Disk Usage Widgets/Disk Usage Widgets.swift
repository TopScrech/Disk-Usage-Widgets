import ScrechKit

@main
struct DiskUsageWidgets: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
        }
        
#if os(macOS)
        MenuBarExtra("Disk Usage", systemImage: "externaldrive") {
            HomeView()
                .frame(width: 600, height: 200)
        }
        .menuBarExtraStyle(.window)
#endif
    }
}
