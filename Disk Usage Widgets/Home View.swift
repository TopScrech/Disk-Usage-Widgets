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
                    VStack(spacing: 0) {
                        Text(disk.freeSpace)
                        
                        Text(disk.freeSpacePercentage)
                            .tertiary()
                    }
                }
                .width(min: 100)
                
                TableColumn("Used Space") { disk in
                    VStack(spacing: 0) {
                        Text(disk.usedSpace)
                        
                        Text(disk.usedSpacePercentage)
                            .tertiary()
                    }
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
                
                TableColumn("isEjectable") { disk in
#if DEBUG
                    if disk.isEjectable {
                        Button("Eject") {
                            if let url = disk.url?.path {
                                vm.ejectDisk(url)
                            } else {
                                print("Path not found")
                            }
                        }
                    }
#else
                    Text(disk.isEjectable ? "+" : "")
#endif
                }
                .width(min: 50)
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
