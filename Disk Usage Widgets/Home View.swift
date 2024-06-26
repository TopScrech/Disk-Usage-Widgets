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
                    Label(disk.name, systemImage: disk.icon)
                }
                
                TableColumn("Type") { disk in
                    Text(disk.type)
                }
                
                TableColumn("Free Space") { disk in
                    Text(disk.freeSpace)
                }
                
                TableColumn("Used Space") { disk in
                    Text(disk.usedSpace)
                }
                
                TableColumn("Total Space") { disk in
                    Text(disk.totalSpace)
                }
                
                TableColumn("Path") { disk in
                    Text(disk.url?.path ?? "-")
                }
                
#if canImport(DiskArbitration)
                TableColumn("isEjectable") { disk in
                    if disk.isEjectable {
                        Button("Eject (not tested)") {
                            if let url = disk.url?.path {
                                vm.ejectDisk(url)
                            }
                        }
                    }
                }
#endif
                
                TableColumn("isEncrypted") { disk in
                    Text(disk.isEncrypted ? "+" : "")
                }
            }
        }
        .scrollIndicators(.never)
        .onReceive(publisher) { _ in
            vm.listAvailableDisks()
        }
        .task {
            vm.listAvailableDisks()
        }
    }
}

#Preview {
    HomeView()
}
