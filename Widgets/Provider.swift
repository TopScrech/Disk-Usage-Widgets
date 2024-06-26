import WidgetKit

struct Provider: AppIntentTimelineProvider {
    private let previewEntry = SimpleEntry(
        date: Date(),
        emoji: "😀",
        disks: [Preview.disk]
    )
    
    func placeholder(
        in context: Context
    ) -> SimpleEntry {
        previewEntry
    }
    
    func snapshot(
        for configuration: ConfigurationAppIntent,
        in context: Context
    ) -> SimpleEntry {
        previewEntry
    }
    
    func timeline(
        for configuration: ConfigurationAppIntent,
        in context: Context
    ) -> Timeline<SimpleEntry> {
        let vm = VM()
        vm.listAvailableDisks()
        
        let entries: [SimpleEntry] = [
            .init(
                date: Date(),
                emoji: "",
                disks: vm.disks
            )
        ]
        
        let timeline = Timeline(
            entries: entries,
            policy: .atEnd
        )
        
        return timeline
    }
    
    //    @available(macOSApplicationExtension 15, *)
    //    func relevances() async -> WidgetRelevances<Void> {
    // Generate a list containing the contexts this widget is releva1nt in
    //    }
}
