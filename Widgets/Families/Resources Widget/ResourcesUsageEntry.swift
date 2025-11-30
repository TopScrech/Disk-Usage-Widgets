import WidgetKit

struct ResourcesUsageEntry: TimelineEntry {
    let date: Date
    let name: String
    let id: String
    let state: String
    let usage: UsageAttributes?
    
    init(
        date: Date,
        name: String,
        id: String,
        state: String,
        usage: UsageAttributes? = nil
    ) {
        self.date = date
        self.name = name
        self.id = id
        self.state = state
        self.usage = usage
    }
}
