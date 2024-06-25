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
                    Label(disk.name, systemImage: disk.isLocal ? "externaldrive" : "externaldrive.connected.to.line.below")
                }
                
                TableColumn("isEjectable") { disk in
                    if disk.isEjectable {
                        Button("Eject (not tested)") {
                            if let url = disk.url?.path {
                                vm.ejectDisk(url)
                            }
                        }
                    }
                }
                
                TableColumn("isEncrypted") { disk in
                    Text(disk.isEncrypted ? "+" : "")
                }
                
                TableColumn("Type") { disk in
                    Text(disk.type)
                }
                
                TableColumn("Free Space") { disk in
                    Text(disk.freeSpace)
                }
                
                TableColumn("Total Space") { disk in
                    Text(disk.totalSpace)
                }
                
                TableColumn("Total Space") { disk in
                    Text(disk.url?.path ?? "-")
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
