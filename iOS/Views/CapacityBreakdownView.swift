import ScrechKit

struct CapacityBreakdownView: View {
    let snapshot: StorageSnapshot
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Capacity")
                .headline()
            
            ProgressView(value: snapshot.usedFraction)
                .tint(.blue)
                .accessibilityLabel("Used capacity")
            
            HStack {
                Label {
                    Text("\(snapshot.usedBytes, format: .byteCount(style: .file)) used")
                } icon: {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(.blue)
                }
                
                Spacer()
                
                Label {
                    Text("\(snapshot.availableBytes, format: .byteCount(style: .file)) available")
                } icon: {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(.green)
                }
            }
            .footnote()
            .monospacedDigit()
            .secondary()
        }
        .padding()
        .background(.background, in: .rect(cornerRadius: 20))
    }
}

#Preview {
    CapacityBreakdownView(snapshot: .preview)
        .padding()
}
