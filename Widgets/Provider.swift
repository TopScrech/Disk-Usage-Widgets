import WidgetKit

struct Provider: AppIntentTimelineProvider {
    private let previewEntry = SimpleEntry(
        date: Date(),
        config: {
            var config = ConfigAppIntent()
            config.selectedDisk = DiskSelection(Preview.disk)
            return config
        }(),
        disk: Preview.disk,
        isSelectedDiskMissing: false
    )
    
    func placeholder(in context: Context) -> SimpleEntry {
        previewEntry
    }
    
    func snapshot(for configuration: ConfigAppIntent, in context: Context) -> SimpleEntry {
        makeEntry(for: configuration)
    }
    
    func timeline(for configuration: ConfigAppIntent, in context: Context) -> Timeline<SimpleEntry> {
        let entries: [SimpleEntry] = [
            makeEntry(for: configuration)
        ]
        
        let nextUpdate = Date().addingTimeInterval(5 * 60) // 5 minutes
        
        let timeline = Timeline(
            entries: entries,
            policy: .after(nextUpdate)
        )
        
        return timeline
    }
    
    //    @available(macOSApplicationExtension 15, *)
    //    func relevances() async -> WidgetRelevances<Void> {
    // Generate a list containing the contexts this widget is releva1nt in
    //    }
    
    private func makeEntry(for configuration: ConfigAppIntent) -> SimpleEntry {
        let vm = VM()
        vm.listAvailableDisks()
        
        let (disk, isMissing) = resolveDisk(
            from: vm.disks,
            using: configuration
        )
        
        return SimpleEntry(
            date: Date(),
            config: configuration,
            disk: disk,
            isSelectedDiskMissing: isMissing
        )
    }
    
    private func resolveDisk(from disks: [DiskEntry], using configuration: ConfigAppIntent) -> (DiskEntry?, Bool) {
        guard let selected = configuration.selectedDisk else {
            return (disks.first, false)
        }
        
        guard let disk = disks.first(where: {
            $0.matches(selected)
        }) else {
            return (nil, true)
        }
        
        return (disk, false)
    }
}

private extension DiskEntry {
    func matches(_ selection: DiskSelection) -> Bool {
        let identifier = url?.absoluteString ?? name
        
        return identifier == selection.id ||
        name == selection.name ||
        localizedName == selection.localizedName
    }
}
