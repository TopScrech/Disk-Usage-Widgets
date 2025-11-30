import AppIntents

struct DiskIntentTypeAppEntityQuery: EntityQuery {
    func entities(for identifiers: [DiskIntentTypeAppEntity.ID]) async throws -> [DiskIntentTypeAppEntity] {
        let availableDisks = disks()
        
        var found = availableDisks.filter {
            identifiers.contains($0.id)
        }
        
        let missingIDs = identifiers.filter { id in
            !found.contains(where: { $0.id == id })
        }
        
        let missingEntities = missingIDs.map { id in
            let displayName = URL(fileURLWithPath: id).lastPathComponent.isEmpty
            ? id
            : URL(fileURLWithPath: id).lastPathComponent
            
            return DiskIntentTypeAppEntity(id: id, displayString: displayName)
        }
        
        found.append(contentsOf: missingEntities)
        return found
    }
    
    func suggestedEntities() async throws -> [DiskIntentTypeAppEntity] {
        disks()
    }
    
    private func disks() -> [DiskIntentTypeAppEntity] {
        let volumes = FileManager.default.mountedVolumeURLs(
            includingResourceValuesForKeys: [.volumeNameKey, .volumeLocalizedNameKey],
            options: .skipHiddenVolumes
        ) ?? []
        
        let mapped = volumes.compactMap { volume -> DiskIntentTypeAppEntity? in
            let values = try? volume.resourceValues(forKeys: [.volumeNameKey, .volumeLocalizedNameKey])
            
            guard let name = values?.volumeLocalizedName ?? values?.volumeName else {
                return nil
            }
            
            return DiskIntentTypeAppEntity(
                id: volume.path,
                displayString: name,
                subtitle: volume.lastPathComponent
            )
        }
        
        if mapped.isEmpty {
            return [
                DiskIntentTypeAppEntity(id: "sample-disk-a", displayString: "Sample Disk A"),
                DiskIntentTypeAppEntity(id: "sample-disk-b", displayString: "Sample Disk B")
            ]
        }
        
        return mapped
    }
}
