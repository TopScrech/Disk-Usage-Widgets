import Foundation

enum StorageReadError: LocalizedError {
    case capacityUnavailable
    
    var errorDescription: String? {
        String(localized: "Storage information is temporarily unavailable")
    }
}
