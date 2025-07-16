import SwiftUI
import WidgetKit
import LaunchAtLogin

struct AppSettings: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Binding private var showMenuBarExtra: Bool
    
    init(_ showMenuBarExtra: Binding<Bool>) {
        _showMenuBarExtra = showMenuBarExtra
    }
    
    var body: some View {
        Form {
            Toggle("Show in Menu Bar", isOn: $showMenuBarExtra)
#if os(macOS)
            LaunchAtLogin.Toggle()
#endif
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
#warning("WTF")
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
}
