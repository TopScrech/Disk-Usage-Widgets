import ScrechKit

@main
struct DiskUsageWidgets: App {
    @NSApplicationDelegateAdaptor(DiskUsageWidgetsAppDelegate.self) private var appDelegate
    
    @AppStorage("hideWindowOnLaunch") private var hideWindowOnLaunch = false
    @AppStorage("keepsWindowOnTop") private var keepsWindowOnTop = false
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
    
    @State private var didApplyLaunchWindowPreference = false
    
    var body: some Scene {
        WindowGroup("App", id: "app") {
            NavigationStack {
                HomeView()
            }
            .frame(minWidth: 600, minHeight: 200)
            .background(MainWindowLevelView(keepsWindowOnTop: keepsWindowOnTop))
            .task {
                await applyLaunchWindowPreference()
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
    
    private func applyLaunchWindowPreference() async {
        guard !didApplyLaunchWindowPreference else { return }
        didApplyLaunchWindowPreference = true
        
        guard hideWindowOnLaunch else { return }
        await Task.yield()
        
        let app = NSApplication.shared
        let window = app.keyWindow ?? app.mainWindow ?? app.windows.first { $0.isVisible }
        window?.orderOut(nil)
    }
}
