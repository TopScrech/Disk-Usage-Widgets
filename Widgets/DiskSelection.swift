import AppIntents

struct DiskSelection: AppEntity, Identifiable {
    static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "Disk")
    static let defaultQuery = DiskSelectionQuery()
    
    let id: String
    let name: String
    let localizedName: String?
    
    init(id: String, name: String, localizedName: String?) {
        self.id = id
        self.name = name
        self.localizedName = localizedName
    }
    
    init(_ disk: DiskEntry) {
        self.id = disk.url?.absoluteString ?? disk.name
        self.name = disk.name
        self.localizedName = disk.localizedName
    }
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)")
    }
}

@MainActor
struct DiskSelectionQuery: EntityQuery {
    func entities(for identifiers: [DiskSelection.ID]) async throws -> [DiskSelection] {
        let ids = Set(identifiers)
        
        return fetchDisks()
            .filter { ids.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [DiskSelection] {
        fetchDisks()
    }
    
    func entities(matching query: String) async throws -> [DiskSelection] {
        let lowercased = query.lowercased()
        
        return fetchDisks().filter {
            $0.name.lowercased().contains(lowercased) ||
            ($0.localizedName?.lowercased().contains(lowercased) ?? false)
        }
    }
    
    private func fetchDisks() -> [DiskSelection] {
        let vm = VM()
        vm.listAvailableDisks()
        
        return vm.disks.map {
            DiskSelection($0)
        }
    }
}
