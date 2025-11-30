import WidgetKit
import Foundation

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
        let result = disks(for: configuration)
        
        return SimpleEntry(
            date: Date(),
            config: configuration,
            disks: result.disks,
            selectedDiskNotFound: result.selectedDiskNotFound
        )
    }
    
    private func disks(for configuration: ConfigAppIntent) -> (disks: [DiskEntry], selectedDiskNotFound: Bool) {
        let vm = VM()
        vm.listAvailableDisks()
        
        guard let selection = configuration.selectedDisk else {
            return (fallbackDisks(vm.disks), false)
        }
        
        let selectedID = selection.id
        let matchedDisk = matchedDisk(in: vm.disks, id: selectedID)
        
        if let matchedDisk {
            return ([matchedDisk], false)
        }
        
        return ([], true)
    }
    
    private func matchedDisk(in disks: [DiskEntry], id: String) -> DiskEntry? {
        disks.first { disk in
            disk.url?.path == id || disk.name == id || disk.localizedName == id
        }
    }
    
    private func fallbackDisks(_ disks: [DiskEntry]) -> [DiskEntry] {
        if disks.isEmpty {
            return Preview.disks
        }
        
        return disks
    }
}
