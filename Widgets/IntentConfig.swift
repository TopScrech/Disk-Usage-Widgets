import SwiftUI
import AppIntents

struct ConfigAppIntent: WidgetConfigurationIntent {
    static let intentClassName = "ServerUsageIntent"
    
    static let title: LocalizedStringResource = "Configuration"
    static let description: IntentDescription = "Disk Usage Widget Configuration"
    
    @Parameter(title: "Refresh Button", default: true)
    var showRefreshButton: Bool
    
    @Parameter(title: "Disk Name", default: true)
    var showDiskName: Bool
    
    @Parameter(title: "Refresh Time", default: true)
    var showRefreshTime: Bool
    
    @Parameter(title: "Total Space", default: true)
    var showTotalSpace: Bool
    
    @Parameter(title: "Build Number", default: false)
    var showBuildNumber: Bool
}

struct RefreshIntent: AppIntent {
    static let title: LocalizedStringResource = "Refresh"
    
    func perform() async throws -> some IntentResult {
        .result()
    }
}
