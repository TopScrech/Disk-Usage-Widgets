import ScrechKit

struct CapacityMetricView: View {
    let title: LocalizedStringKey
    let bytes: Int64
    let systemImage: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .title2()
                .foregroundStyle(color)
                .frame(44)
                .background(color.opacity(0.12), in: .rect(cornerRadius: 12))
            
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
        .padding()
        .background(.background, in: .rect(cornerRadius: 20))
    }
}
