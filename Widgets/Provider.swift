import WidgetKit

struct Provider: AppIntentTimelineProvider {
    private let previewEntry = SimpleEntry(
        date: Date(),
        configuration: ConfigurationAppIntent(),
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
        
#if DEBUG
        let entries: [SimpleEntry] = [previewEntry]
#else
        let entries: [SimpleEntry] = [
            .init(
                date: Date(),
                configuration: configuration,
                disks: vm.disks
            )
        ]
#endif
        
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
