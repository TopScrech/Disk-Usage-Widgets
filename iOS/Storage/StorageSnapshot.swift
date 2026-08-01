import Foundation

struct StorageSnapshot: Equatable, Sendable {
    let name: String
    let fileSystem: String
    let availableBytes: Int64
    let totalBytes: Int64
    let updatedAt: Date
    
    var usedBytes: Int64 {
        max(totalBytes - availableBytes, 0)
    }
    
    var usedFraction: Double {
        guard totalBytes > 0 else { return 0 }
        return min(max(Double(usedBytes) / Double(totalBytes), 0), 1)
    }
    
    var availableFraction: Double {
        1 - usedFraction
    }
    
    var status: StorageStatus {
        switch availableFraction {
        case 0.2...: .comfortable
        case 0.1...: .limited
        default: .critical
        }
    }
}
