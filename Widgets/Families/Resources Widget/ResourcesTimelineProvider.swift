import WidgetKit

struct ResourcesTimelineProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> ResourcesUsageEntry {
        sampleEntry()
    }
    
    func getSnapshot(for configuration: CryptoPriceConfigurationIntent, in context: Context, completion: @escaping (ResourcesUsageEntry) -> Void) {
        completion(snapshotEntry(for: configuration))
    }
    
    func getTimeline(for configuration: CryptoPriceConfigurationIntent, in context: Context, completion: @escaping @Sendable (Timeline<ResourcesUsageEntry>) -> Void) {
        guard let selectedServer = configuration.selectedServer else {
            executeTimelineCompletion(
                completion,
                timelineEntry: ResourcesUsageEntry(date: Date(), name: "", id: "", state: "No disk selected")
            )
            
            return
        }
        
        let serverIDForRequest = selectedServer.id ?? selectedServer.identifier ?? UUID().uuidString
        let serverIDForEntry = selectedServer.id ?? selectedServer.identifier ?? ""
        let serverName = selectedServer.name ?? selectedServer.displayString
        
        Task { @MainActor in
            let usage = await Networking.fetchResourceUsage(serverIDForRequest)
            
            let entry = ResourcesUsageEntry(
                date: Date(),
                name: serverName,
                id: serverIDForEntry,
                state: usage.state,
                usage: usage.usage
            )
            
            executeTimelineCompletion(completion, timelineEntry: entry)
        }
    }
    
    private func snapshotEntry(for configuration: CryptoPriceConfigurationIntent) -> ResourcesUsageEntry {
        guard let selection = configuration.selectedServer else {
            return sampleEntry()
        }
        
        return ResourcesUsageEntry(
            date: Date(),
            name: selection.name ?? "Snapshot Disk",
            id: selection.id ?? "snapshot-id",
            state: "running",
            usage: .init(memory: 32, cpu: 54, disk: 280)
        )
    }
    
    private func sampleEntry() -> ResourcesUsageEntry {
        ResourcesUsageEntry(
            date: Date(),
            name: "Preview Disk",
            id: "disk-0",
            state: "running",
            usage: .init(memory: 24, cpu: 73, disk: 220)
        )
    }
    
    private func executeTimelineCompletion(
        _ completion: @escaping (Timeline<ResourcesUsageEntry>) -> Void,
        timelineEntry: ResourcesUsageEntry
    ) {
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) ?? Date().addingTimeInterval(900)
        completion(Timeline(entries: [timelineEntry], policy: .after(nextUpdate)))
    }
}
