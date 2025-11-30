import SwiftUI
import AppIntents

struct ConfigAppIntent: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "CryptoPriceConfigurationIntent"
    
    static let title: LocalizedStringResource = "Configuration"
    static let description: IntentDescription = "Disk Usage Widget Configuration"
    
    // Not for shortcuts
    static let isDiscoverable = false
    
    @Parameter(title: "Disk")
    var selectedDisk: DiskIntentTypeAppEntity?
    
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
    
    static var parameterSummary: some ParameterSummary {
        Summary {
            \.$selectedDisk
            \.$showRefreshButton
            \.$showDiskName
            \.$showRefreshTime
            \.$showTotalSpace
            \.$showBuildNumber
        }
    }
}

struct RefreshIntent: AppIntent {
    static let title: LocalizedStringResource = "Refresh"
    
    func perform() async throws -> some IntentResult {
        .result()
    }
}
