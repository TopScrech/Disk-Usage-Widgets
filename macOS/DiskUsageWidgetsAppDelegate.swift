import SwiftUI

final class DiskUsageWidgetsAppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        DockIconVisibilityController.applyStoredPreference()
    }
}
