import WidgetKit

struct ResourcesUsageEntry: TimelineEntry {
    let date: Date
    let name: String
    let id: String
    
    init(date: Date, name: String, id: String) {
        self.date = date
        self.name = name
        self.id = id
    }
}
