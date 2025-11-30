import WidgetKit

struct Provider: AppIntentTimelineProvider {
    private let previewEntry = SimpleEntry(date: Date(), config: ConfigAppIntent(), disks: Preview.disks)
    
    func placeholder(in context: Context) -> SimpleEntry {
        previewEntry
    }
    
    func snapshot(for configuration: ConfigAppIntent, in context: Context) async -> SimpleEntry {
        entry(for: configuration)
    }
    
    func timeline(for configuration: ConfigAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let entry = entry(for: configuration)
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: Date()) ?? Date().addingTimeInterval(5 * 60)
        
        return Timeline(entries: [entry], policy: .after(nextUpdate))
    }
    
    private func entry(for configuration: ConfigAppIntent) -> SimpleEntry {
        let disks = disks(for: configuration)
        return SimpleEntry(date: Date(), config: configuration, disks: disks)
    }
    
    private func disks(for configuration: ConfigAppIntent) -> [DiskEntry] {
        let vm = VM()
        vm.listAvailableDisks()
        
        guard let selection = configuration.selectedDisk else {
            return fallbackDisks(vm.disks)
        }
        
        let selectedID = selection.id
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
