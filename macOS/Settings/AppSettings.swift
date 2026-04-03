import SwiftUI
import WidgetKit
import LaunchAtLogin

struct AppSettings: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @AppStorage("hideWindowOnLaunch") private var hideWindowOnLaunch = false
    @AppStorage("keepsWindowOnTop") private var keepsWindowOnTop = false
    @AppStorage(DockIconVisibilityController.hidesDockIconDefaultsKey) private var hidesDockIcon = false
    
    @Binding private var showMenuBarExtra: Bool
    
    init(_ showMenuBarExtra: Binding<Bool>) {
        _showMenuBarExtra = showMenuBarExtra
    }
    
    var body: some View {
        Form {
            Section("Launch") {
                LaunchAtLogin.Toggle("Launch at login")
                Toggle("Hide window on launch", isOn: $hideWindowOnLaunch)
                Toggle("Hide Dock icon", isOn: $hidesDockIcon)
                Toggle("Keep on top of other windows", isOn: $keepsWindowOnTop)
                Toggle("Show in Menu Bar", isOn: $showMenuBarExtra)
            }
            
            HStack {
                Text("App Version")
                
                Spacer()
                
                Text("v\(version) (B\(build))")
                    .secondary()
            }
#if DEBUG
            Section("Debug") {
                Button("Reload all widgets") {
                    reloadAllWidgets()
                }
            }
#endif
        }
        .frame(width: 500, height: 600)
        .formStyle(.grouped)
        .buttonStyle(.plain)
        .background(MainWindowLevelView(keepsWindowOnTop: keepsWindowOnTop))
        .onChange(of: hidesDockIcon, initial: true) { _, newValue in
            DockIconVisibilityController.setDockIconHidden(newValue)
        }
#warning("Works weirdly")
        //            Button(showMenuBarExtra ? "Switch to app" : "Switch to Menu Bar") {
        //                showMenuBarExtra.toggle()
        //
        //                delay(0.5) {
        //                    if showMenuBarExtra {
        //                        openWindow(id: "app")
        //                    } else {
        //                        dismissWindow(id: "app")
        //                    }
        //                }
        //            }
        //            .padding(.top)
    }
    
    private func reloadAllWidgets() {
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    private var version: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            version
        } else {
            "Unknown"
        }
    }
    
    private var build: String {
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            build
        } else {
            "Unknown"
        }
    }
}

#Preview {
    @Previewable @State var showMenuBarExtra = false
    
    AppSettings($showMenuBarExtra)
        .darkSchemePreferred()
}
