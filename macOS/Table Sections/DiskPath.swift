import ScrechKit

struct DiskPath: View {
    private let path: String?
    
    init(_ path: String?) {
        self.path = path
    }
    
    var body: some View {
        if let path {
            Button(path) {
                openInFinder(path, rootedAt: path)
            }
        }
    }
}

#Preview {
    DiskPath("/")
        .darkSchemePreferred()
}
