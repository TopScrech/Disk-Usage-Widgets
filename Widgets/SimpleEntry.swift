import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let config: ConfigAppIntent
    let disk: DiskEntry?
    let isSelectedDiskMissing: Bool
}
