import SwiftUI
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static let intentClassName = "ServerUsageIntent"
    
    static var title: LocalizedStringResource = "Configuration"
    static var description: IntentDescription = " "
    
    @Parameter(title: "Show refresh button", default: false)
    var showRefreshButton: Bool
    
    @Parameter(title: "Show refresh time", default: true)
    var showRefreshTime: Bool
    
    @Parameter(title: "Show total space", default: true)
    var showTotalSpace: Bool
    
    @Parameter(title: "Show build number", default: false)
    var showBuildNumber: Bool
}

struct RefreshIntent: AppIntent {
    static var title: LocalizedStringResource = "Refresh"
    
    func perform() async throws -> some IntentResult {
        .result()
    }
}
