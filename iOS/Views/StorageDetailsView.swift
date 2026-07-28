import ScrechKit

struct StorageDetailsView: View {
    let snapshot: StorageSnapshot

    var body: some View {
        VStack(alignment: .leading) {
            Text("Details")
                .headline()

            LabeledContent("Volume", value: snapshot.name)

            Divider()

            LabeledContent("Format", value: snapshot.fileSystem)

            Divider()

            LabeledContent("Updated") {
                Text(snapshot.updatedAt, format: .dateTime.hour().minute().second())
            }
        }
        .padding()
        .background(.background, in: .rect(cornerRadius: 20))
    }
}

#Preview {
    StorageDetailsView(snapshot: .preview)
        .padding()
}
