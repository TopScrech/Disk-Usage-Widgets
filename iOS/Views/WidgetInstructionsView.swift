import ScrechKit

struct WidgetInstructionsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Label("Add the Home Screen widget", systemImage: "rectangle.3.group.fill")
                .headline()

            Text("Keep your available storage visible without opening the app")
                .secondary()

            Label("Touch and hold the Home Screen, then tap Edit", systemImage: "1.circle.fill")
            Label("Choose Add Widget and search for Disk Usage", systemImage: "2.circle.fill")
            Label("Pick a size, add it, then place it where you like", systemImage: "3.circle.fill")
        }
        .padding()
        .background(.blue.opacity(0.1), in: .rect(cornerRadius: 20))
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    WidgetInstructionsView()
        .padding()
}
