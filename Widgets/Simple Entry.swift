import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigAppIntent
    
    var disks: [DiskEntry] = []
}
