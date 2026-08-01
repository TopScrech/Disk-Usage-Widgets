import Foundation

struct SavedExternalDrive: Identifiable, Codable, Equatable, Sendable {
    let id: UUID
    var name: String
    let bookmark: Data
}
