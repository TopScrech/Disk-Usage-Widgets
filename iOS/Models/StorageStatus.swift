import ScrechKit

enum StorageStatus: Sendable {
    case comfortable, limited, critical
    
    var title: LocalizedStringKey {
        switch self {
        case .comfortable: "Storage looks good"
        case .limited: "Storage is getting full"
        case .critical: "Storage is critically low"
        }
    }
    
    var message: LocalizedStringKey {
        switch self {
        case .comfortable:
            "There is plenty of space available for apps, photos, and system updates"
            
        case .limited:
            "Consider removing downloads or unused apps before installing a large update"
            
        case .critical:
            "Free up space soon to keep downloads, updates, and everyday tasks working reliably"
        }
    }
    
    var systemImage: String {
        switch self {
        case .comfortable: "checkmark.circle.fill"
        case .limited: "exclamationmark.circle.fill"
        case .critical: "exclamationmark.triangle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .comfortable: .green
        case .limited: .orange
        case .critical: .red
        }
    }
}
