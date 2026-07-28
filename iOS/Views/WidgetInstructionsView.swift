import ScrechKit

struct WidgetInstructionsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Adding Home Screen widgets", systemImage: "rectangle.3.group.fill")
                .headline()
            
            Text("1. Touch and hold the Home Screen, then tap Edit")
            Text("2. Choose Add Widget and search for Disk Usage")
            Text("3. Pick a size, add it, then place it where you like")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(.blue.opacity(0.1), in: .rect(cornerRadius: 20))
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    WidgetInstructionsView()
        .padding()
}
