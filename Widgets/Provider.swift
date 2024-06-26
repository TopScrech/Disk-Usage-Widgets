import WidgetKit

struct Provider: TimelineProvider {
    private let previewEntry = SimpleEntry(
        date: Date(),
        emoji: "😀",
        disks: [Preview.disk]
    )
    
    func placeholder(in context: Context) -> SimpleEntry {
        previewEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(previewEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
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
        
        completion(timeline)
    }
    
    //    @available(macOSApplicationExtension 15, *)
    //    func relevances() async -> WidgetRelevances<Void> {
    // Generate a list containing the contexts this widget is releva1nt in
    //    }
}
