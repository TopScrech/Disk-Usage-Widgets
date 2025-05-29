import WidgetKit

struct Provider: AppIntentTimelineProvider {
    private let previewEntry = SimpleEntry(
        date: Date(),
        configuration: ConfigurationAppIntent(),
        disks: Utils.previewDisks
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
        let vm = VM()
        vm.listAvailableDisks()
        
        return SimpleEntry(
            date: Date(),
            configuration: configuration,
            disks: vm.disks
        )
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
                configuration: configuration,
                disks: vm.disks
            )
        ]
        let nextUpdate = Date().addingTimeInterval(5 * 60) // 5 minutes
        
        let timeline = Timeline(
            entries: entries,
            policy: .after(nextUpdate)
        )
        
        return timeline
    }
    
    //    @available(macOSApplicationExtension 15, *)
    //    func relevances() async -> WidgetRelevances<Void> {
    // Generate a list containing the contexts this widget is releva1nt in
    //    }
}
