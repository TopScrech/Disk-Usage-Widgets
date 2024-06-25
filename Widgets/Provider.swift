import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            emoji: "😀"
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            emoji: "😀"
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entries: [SimpleEntry] = [
            .init(
                date: Date(),
                emoji: ""
            )
        ]
        
        //        let currentDate = Date()
        //        for hourOffset in 0 ..< 5 {
        //            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
        //            let entry = SimpleEntry(date: entryDate, emoji: "😀")
        //            entries.append(entry)
        //        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    //    @available(macOSApplicationExtension 15, *)
    //    func relevances() async -> WidgetRelevances<Void> {
    // Generate a list containing the contexts this widget is relevant in
    //    }
}
