import Foundation

enum StorageReadError: LocalizedError {
    case capacityUnavailable
    
    var errorDescription: String? {
        "Storage information is temporarily unavailable"
    }
}
