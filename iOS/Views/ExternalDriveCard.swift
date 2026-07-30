import ScrechKit

struct ExternalDriveCard: View {
    private let drive: ExternalDriveSnapshot
    
    init(_ drive: ExternalDriveSnapshot) {
        self.drive = drive
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Label(drive.storage.name, systemImage: "externaldrive.connected.to.line.below")
                .headline()
            
            ProgressView(value: drive.storage.usedFraction)
                .tint(.blue)
                .accessibilityLabel("Used capacity")
            
            HStack {
                Text("\(drive.storage.availableBytes, format: .byteCount(style: .file)) available")
                
                Spacer()
                
                Text("\(drive.storage.totalBytes, format: .byteCount(style: .file)) total")
            }
            .footnote()
            .monospacedDigit()
            .secondary()
            
            Text(drive.storage.fileSystem)
                .caption(.semibold, design: .monospaced)
                .secondary()
                .padding(.top, 1)
        }
        .background(.background, in: .rect(cornerRadius: 20))
    }
}

#Preview {
    ExternalDriveCard(ExternalDriveSnapshot(id: UUID(), storage: .preview))
        .padding()
}
