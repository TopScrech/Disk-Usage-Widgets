import AppIntents

struct RefreshIntent: AppIntent {
    static let title: LocalizedStringResource = "Refresh"
    
    func perform() async throws -> some IntentResult {
        .result()
    }
}
