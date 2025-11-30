import Intents

class IntentHandler: INExtension, CryptoPriceConfigurationIntentHandling {
    func provideSelectedDiskOptionsCollection(for intent: CryptoPriceConfigurationIntent) async throws -> INObjectCollection<Crypto> {
        let volumes = FileManager.default.mountedVolumeURLs(
            includingResourceValuesForKeys: [.volumeNameKey, .volumeLocalizedNameKey],
            options: .skipHiddenVolumes
        ) ?? []
        
        let disks: [Crypto] = volumes.compactMap { volume in
            let values = try? volume.resourceValues(forKeys: [.volumeNameKey, .volumeLocalizedNameKey])
            
            guard let name = values?.volumeLocalizedName ?? values?.volumeName else {
                return nil
            }
            
            let subtitle = volume.lastPathComponent
            return Crypto(identifier: volume.path, display: name, subtitle: subtitle, image: nil)
        }
        
        let fallback = [
            Crypto(identifier: "sample-disk-a", display: "Sample Disk A", subtitle: "example", image: nil),
            Crypto(identifier: "sample-disk-b", display: "Sample Disk B", subtitle: "example", image: nil)
        ]
        
        return INObjectCollection(items: disks.isEmpty ? fallback : disks)
    }
    
    override func handler(for intent: INIntent) -> Any {
        self
    }
}
