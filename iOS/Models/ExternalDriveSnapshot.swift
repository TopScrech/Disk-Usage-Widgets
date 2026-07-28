import Foundation

struct ExternalDriveSnapshot: Identifiable, Equatable, Sendable {
    let id: UUID
    let storage: StorageSnapshot
}
