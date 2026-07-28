import ScrechKit
import Appearance

@main
struct iOSApp: App {
    @AppStorage("appearance") private var appearance: Appearance = .system

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(appearance.scheme)
        }
    }
}
