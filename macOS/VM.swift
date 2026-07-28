import ScrechKit
import OSLog

@Observable
final class VM {
    var disks: [DiskEntry] = []

    private let fm = FileManager.default

    func listAvailableDisks() {
#if os(iOS)
        guard let disk = processVolume(.documentsDirectory) else {
            Logger().error("Failed to retrieve device storage")
            disks = []
            return
        }

        disks = [disk]
#else
        let volumes = fm.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: .skipHiddenVolumes)

        guard let volumes else {
            Logger().error("Failed to retrieve mounted volume URL's")
            return
        }

        disks = volumes.compactMap {
            processVolume($0)
        }
#endif
    }

    private func processVolume(_ volume: URL) -> DiskEntry? {
        do {
            let keys: Set<URLResourceKey> = [
                .volumeNameKey,
                .volumeLocalizedNameKey,
                .volumeIsLocalKey,
                .volumeTypeNameKey,
                .volumeIsEjectableKey,
                .volumeIsEncryptedKey
            ]

            let resourceValues = try volume.resourceValues(forKeys: keys)

#if os(iOS)
            let name = resourceValues.volumeLocalizedName ?? resourceValues.volumeName ?? "Device Storage"
            let localizedName = resourceValues.volumeLocalizedName ?? name
            let isLocal = resourceValues.volumeIsLocal ?? true
            let type = resourceValues.volumeTypeName ?? "APFS"
            let isEjectable = resourceValues.volumeIsEjectable ?? false
            let isEncrypted = resourceValues.volumeIsEncrypted ?? true
#else
            guard
                let name =          resourceValues.volumeName,
                let localizedName = resourceValues.volumeLocalizedName,
                let isLocal =       resourceValues.volumeIsLocal,
                let type =          resourceValues.volumeTypeName,
                let isEjectable =   resourceValues.volumeIsEjectable,
                let isEncrypted =   resourceValues.volumeIsEncrypted
            else {
                return nil
            }
#endif

            let space =      try fm.volumeFreeDiskSpace(volume)
            let totalSpace = try fm.volumeTotalDiskSpace(volume)

            let disk = DiskEntry(
                url: volume,
                name: name,
                type: type.uppercased(),
                isLocal: isLocal,
                isEjectable: isEjectable,
                isEncrypted: isEncrypted,
                localizedName: localizedName,
                freeSpaceBytes: space,
                totalSpaceBytes: totalSpace
            )

            return disk

        } catch {
            Logger().error("Error retrieving resource values for \(volume): \(error)")
            return nil
        }
    }
}
