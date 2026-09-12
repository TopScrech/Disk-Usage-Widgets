import ScrechKit

struct StorageUnavailableView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        ContentUnavailableView {
            Label("Storage Unavailable", systemImage: "externaldrive.badge.exclamationmark")
        } description: {
            Text(message)
        } actions: {
            Button("Try Again", systemImage: "arrow.clockwise", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .containerRelativeFrame([.horizontal, .vertical])
    }
}
