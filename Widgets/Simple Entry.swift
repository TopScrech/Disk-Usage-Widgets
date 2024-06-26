import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
    
    var disks: [DiskEntry] = []
}
