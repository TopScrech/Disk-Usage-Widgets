import ScrechKit

struct SavedExternalDriveRowView: View {
    let drive: SavedExternalDrive
    let isConnected: Bool

    var body: some View {
        Label {
            VStack(alignment: .leading) {
                Text(drive.name)

                Text(isConnected ? "Connected" : "Disconnected")
                    .caption()
                    .secondary()
            }
        } icon: {
            Image(systemName: isConnected ? "externaldrive.fill" : "externaldrive")
                .foregroundStyle(isConnected ? .green : .secondary)
        }
    }
}

#Preview {
    List {
        SavedExternalDriveRowView(
            drive: SavedExternalDrive(
                id: UUID(),
                name: "Archive",
                bookmark: Data()
            ),
            isConnected: true
        )
    }
}
