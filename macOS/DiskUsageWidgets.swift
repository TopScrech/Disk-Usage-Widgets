import ScrechKit

@main
struct DiskUsageWidgets: App {
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
    
    var body: some Scene {
        WindowGroup("App", id: "app") {
            NavigationStack {
                HomeView()
            }
        }
        
#if os(macOS)
        MenuBarExtra("Menu Bar Extra", systemImage: "externaldrive", isInserted: $showMenuBarExtra) {
            HomeView()
                .frame(width: 600, height: 200)
        }
        .menuBarExtraStyle(.window)
        
        Settings {
            AppSettings($showMenuBarExtra)
        }
#endif
    }
}
