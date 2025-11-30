import SwiftUI

struct MissingDiskView: View {
    let isSelectedDiskMissing: Bool
    
    private var title: String {
        isSelectedDiskMissing ? "Selected disk not found" : "No disk available"
    }
    
    private var subtitle: String {
        isSelectedDiskMissing ?
        "Choose another disk in the widget settings." :
        "Connect a disk to view usage."
    }
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: isSelectedDiskMissing ? "externaldrive.badge.xmark" : "externaldrive")
                .font(.title2)
                .foregroundStyle(.secondary)
            
            Text(title)
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Text(subtitle)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
