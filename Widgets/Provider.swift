import WidgetKit

struct Provider: IntentTimelineProvider {
    private let previewEntry = SimpleEntry(date: Date(), config: ConfigAppIntent(), disks: Preview.disks)
    private let defaultConfig = ConfigAppIntent()
    
    func placeholder(in context: Context) -> SimpleEntry {
        previewEntry
    }
    
    func getSnapshot(for configuration: CryptoPriceConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(entry(for: configuration))
    }
    
    func getTimeline(for configuration: CryptoPriceConfigurationIntent, in context: Context, completion: @escaping @Sendable (Timeline<SimpleEntry>) -> Void) {
        let entry = entry(for: configuration)
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: Date()) ?? Date().addingTimeInterval(5 * 60)
        
        completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
    }
    
    private func entry(for configuration: CryptoPriceConfigurationIntent) -> SimpleEntry {
        let disks = disks(for: configuration)
        return SimpleEntry(date: Date(), config: defaultConfig, disks: disks)
    }
    
    private func disks(for configuration: CryptoPriceConfigurationIntent) -> [DiskEntry] {
        let vm = VM()
        vm.listAvailableDisks()
        
        guard let selection = configuration.selectedServer else {
            return fallbackDisks(vm.disks)
        }
        
        let selectedID = selection.id ?? selection.identifier ?? ""
        let matchedDisk = vm.disks.first { disk in
            disk.url?.path == selectedID || disk.name == selectedID || disk.localizedName == selectedID
        }
        
        if let matchedDisk {
            return [matchedDisk]
        }
        
        return fallbackDisks(vm.disks)
    }
    
    private func fallbackDisks(_ disks: [DiskEntry]) -> [DiskEntry] {
        if disks.isEmpty {
            return Preview.disks
        }
        
        return disks
    }
}
