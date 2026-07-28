import Foundation

struct ExternalDriveSnapshot: Identifiable, Equatable, Sendable {
    let id: Data
    let storage: StorageSnapshot
}
