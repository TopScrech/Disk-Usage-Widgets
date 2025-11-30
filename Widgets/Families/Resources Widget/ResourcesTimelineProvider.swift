import WidgetKit

struct ResourcesTimelineProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> ResourcesUsageEntry {
        sampleEntry()
    }
    
    func getSnapshot(for configuration: CryptoPriceConfigurationIntent, in context: Context, completion: @escaping (ResourcesUsageEntry) -> Void) {
        completion(snapshotEntry(for: configuration))
    }
    
    func getTimeline(for configuration: CryptoPriceConfigurationIntent, in context: Context, completion: @escaping @Sendable (Timeline<ResourcesUsageEntry>) -> Void) {
        guard let selectedDisk = configuration.selectedDisk else {
            executeTimelineCompletion(
                completion,
                timelineEntry: ResourcesUsageEntry(date: Date(), name: "", id: "")
            )
            
            return
        }
        
        let diskIDForEntry = selectedDisk.id ?? selectedDisk.identifier ?? ""
        let diskName = selectedDisk.name ?? selectedDisk.displayString
        
        Task { @MainActor in
            let entry = ResourcesUsageEntry(date: Date(), name: diskName, id: diskIDForEntry)
            executeTimelineCompletion(completion, timelineEntry: entry)
        }
    }
    
    private func snapshotEntry(for configuration: CryptoPriceConfigurationIntent) -> ResourcesUsageEntry {
        guard let selection = configuration.selectedDisk else {
            return sampleEntry()
        }
        
        return ResourcesUsageEntry(
            date: Date(),
            name: selection.name ?? "Snapshot Disk",
            id: selection.id ?? "snapshot-id"
        )
    }
    
    private func sampleEntry() -> ResourcesUsageEntry {
        ResourcesUsageEntry(date: Date(), name: "Preview Disk", id: "disk-0")
    }
    
    private func executeTimelineCompletion(
        _ completion: @escaping (Timeline<ResourcesUsageEntry>) -> Void,
        timelineEntry: ResourcesUsageEntry
    ) {
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) ?? Date().addingTimeInterval(900)
        completion(Timeline(entries: [timelineEntry], policy: .after(nextUpdate)))
    }
}
