import ScrechKit

struct StorageStatus: View {
    let snapshot: StorageSnapshot
    
    var body: some View {
        HStack {
            Image(systemName: snapshot.status.systemImage)
                .title()
                .foregroundStyle(snapshot.status.color)
            
            VStack(alignment: .leading) {
                Text(snapshot.status.title)
                    .headline()
                
                Text(snapshot.status.message)
                    .secondary()
            }
            
            Spacer()
        }
        .padding()
        .background(snapshot.status.color.opacity(0.1), in: .rect(cornerRadius: 20))
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    StorageStatus(snapshot: .preview)
        .padding()
}
