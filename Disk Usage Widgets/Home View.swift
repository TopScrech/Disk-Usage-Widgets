import SwiftUI

struct HomeView: View {
    private var vm = VM()
    
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
                TableColumn("Name") { disk in
                    Label(disk.name, systemImage: disk.icon)
                }
                .width(min: 150)
                
                TableColumn("Type") { disk in
                    if disk.isEncrypted {
                        Text("\(disk.type) 􀞚")
                            .help("Encrypted")
                    } else {
                        Text(disk.type)
                    }
                }
                .width(min: 60)
                
                TableColumn("Free Space") { disk in
                    Text(disk.freeSpace)
                }
                .width(min: 100)
                
                TableColumn("Used Space") { disk in
                    Text(disk.usedSpace)
                }
                .width(min: 100)
                
                TableColumn("Total Space") { disk in
                    Text(disk.totalSpace)
                }
                .width(min: 100)
                
                TableColumn("Path") { disk in
                    Text(disk.url?.path ?? "-")
                }
                .width(min: 50)
                
#if canImport(DiskArbitration)
                TableColumn("isEjectable") { disk in
                    Text(disk.isEjectable ? "+" : "")
                    
                    //                    if disk.isEjectable {
                    //                        Button("Eject") {
                    //                            if let url = disk.url?.path {
                    //                                vm.ejectDisk(url)
                    //                            } else {
                    //                                print("Path not found")
                    //                            }
                    //                        }
                    //                    }
                }
                .width(min: 50)
#endif
            }
        }
        .title3()
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
