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
                    HStack(spacing: 5) {
                        VStack(alignment: .trailing, spacing: 0) {
                            Text(disk.freeSpace)
                            
                            Text(disk.freeSpacePercentage)
                                .tertiary()
                        }
                        
                        Gauge(value: Double(disk.freeSpaceBytes), in: 0...Double(disk.totalSpaceBytes)) {}
                            .gaugeStyle(.accessoryCircularCapacity)
                            .scaleEffect(0.6)
                            .tint(.green)
                    }
                }
                .width(min: 100)
                
                TableColumn("Used Space") { disk in
                    HStack(spacing: 5) {
                        VStack(alignment: .trailing, spacing: 0) {
                            Text(disk.usedSpace)
                            
                            Text(disk.usedSpacePercentage)
                                .tertiary()
                        }
                        
                        Gauge(value: Double(disk.usedSpaceBytes), in: 0...Double(disk.totalSpaceBytes)) {}
                            .gaugeStyle(.accessoryCircularCapacity)
                            .scaleEffect(0.6)
                            .tint(.red)
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
                
                TableColumn("Ejectable") { disk in
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
        .navigationTitle("Connected Disks")
        .title3()
        .animation(.default, value: vm.disks)
        .scrollIndicators(.never)
        .onReceive(publisher) { _ in
            vm.listAvailableDisks()
        }
        .task {
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
