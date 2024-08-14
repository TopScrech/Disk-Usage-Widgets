import SwiftUI
import WidgetKit

struct AppSettings: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Binding private var showMenuBarExtra: Bool
    
    init(_ showMenuBarExtra: Binding<Bool>) {
        _showMenuBarExtra = showMenuBarExtra
    }
    
    
    var body: some View {
        VStack(spacing: 20) {
            Button(showMenuBarExtra ? "Disable MenuBar app" : "Enable MenuBar app") {
                showMenuBarExtra.toggle()
            }
            
            Button("Debug") {
                WidgetCenter.shared.reloadAllTimelines()
            }
            
            Text("App Version: \(appVersion) B\(buildNumber)")
                .foregroundStyle(.secondary)
        }
        .padding(50)
        
#warning("WTF")
        //            Button(showMenuBarExtra ? "Switch to app" : "Switch to MenuBar") {
        //                showMenuBarExtra.toggle()
        //
        //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        //                    if showMenuBarExtra {
        //                        openWindow(id: "app")
        //                    } else {
        //                        dismissWindow(id: "app")
        //                    }
        //                }
        //            }
        //            .padding(.top)
    }
    
    private var appVersion: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            version
        } else {
            "Unknown"
        }
    }
    
    private var buildNumber: String {
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            build
        } else {
            "Unknown"
        }
    }
}

#warning("iOS 18")
//#Preview {
//    @Previewable @State var showMenuBarExtra = false
//    
//    AppSettings($showMenuBarExtra)
//}
