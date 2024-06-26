import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static let intentClassName = "ServerUsageIntent"
    
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget")
    
    @Parameter(title: "Show build number", default: false)
    var showBuildNumber: Bool
    
    @Parameter(title: "Show refresh button", default: false)
    var showRefreshButton: Bool
    
    @Parameter(title: "Show refresh time", default: true)
    var showRefreshTime: Bool
}

struct RefreshIntent: AppIntent {
    static var title: LocalizedStringResource = "Refresh"
    
    func perform() async throws -> some IntentResult {
        .result()
    }
}
