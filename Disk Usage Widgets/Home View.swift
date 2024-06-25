import SwiftUI

struct HomeView: View {
    private var vm = VM()
    
#if os(macOS)
    private let publisher = NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)
#else
    private let publisher = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
#endif
    
    var body: some View {
        VStack {            
            Table(vm.disks) {
                TableColumn("Name") { disk in
                    Text(disk.name)
                }
                
                TableColumn("Free Space") { disk in
                    Text(disk.freeSpace)
                }
                
                TableColumn("Total Space") { disk in
                    Text(disk.totalSpace)
                }
            }
            .onReceive(publisher) { _ in
                vm.listAvailableDisks()
            }
        }
    }
}

#Preview {
    HomeView()
}
