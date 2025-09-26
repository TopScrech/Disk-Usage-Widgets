import SwiftUI

struct HomeView: View {
    @State private var vm = VM()
    
#if os(macOS)
    private let publisher = NotificationCenter.default.publisher(
        for: NSApplication.didBecomeActiveNotification
    )
#else
    private let publisher = NotificationCenter.default.publisher(
        for: UIApplication.didBecomeActiveNotification
    )
#endif
    
    var body: some View {
        VStack {
            Table(vm.disks) {
                TableColumn("Name") {
                    Label($0.name, systemImage: $0.icon)
                }
                .width(min: 150)
                
                TableColumn("Type") {
                    DiskTypeSection($0)
                }
                .width(min: 60)
                
                TableColumn("Free Space") {
                    DiskFreeSpaceSection($0)
                }
                .width(min: 140)
                
                TableColumn("Used Space") {
                    DiskUsedSpaceSection($0)
                }
                .width(min: 140)
                
                TableColumn("Total Space") {
                    Text($0.totalSpace)
                }
                .width(min: 100)
                
                TableColumn("Path") {
                    Text($0.url?.path ?? "-")
                }
                .width(min: 50)
                
                TableColumn("Ejectable") {
                    DiskEjectableSection($0)
                }
                .width(min: 50)
            }
        }
        .navigationTitle("Connected Disks")
        .title3()
        .animation(.default, value: vm.disks)
        .scrollIndicators(.never)
        .task {
            vm.listAvailableDisks()
        }
        .onReceive(publisher) { _ in
            vm.listAvailableDisks()
        }
        .toolbar {
            HomeViewToolbar()
                .environment(vm)
        }
    }
}

#Preview {
    HomeView()
        .darkSchemePreferred()
}
