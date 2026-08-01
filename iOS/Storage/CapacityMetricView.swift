import ScrechKit

struct CapacityMetricView: View {
    let title: LocalizedStringKey
    let bytes: Int64
    let systemImage: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .offset(x: 3)
                .title2()
                .foregroundStyle(color)
                .frame(60)
                .background(color.opacity(0.12), in: .rect)
            
            VStack(alignment: .leading) {
                Text(title)
                    .secondary()
                
                Text(bytes, format: .byteCount(style: .file))
                    .title2(.bold)
                    .monospacedDigit()
                    .numericTransition(bytes)
            }
            
            Spacer()
        }
        .background(.background, in: .capsule)
        .clipShape(.capsule)
    }
}
