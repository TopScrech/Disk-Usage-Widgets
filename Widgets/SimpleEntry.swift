import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let config: ConfigAppIntent
    
    var disks: [DiskEntry] = []
    var selectedDiskNotFound = false
}
