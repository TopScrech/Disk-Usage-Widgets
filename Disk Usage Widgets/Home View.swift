import SwiftUI

struct HomeView: View {
    private var vm = VM()
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Binding private var showMenuBarExtra: Bool
    
    init(_ showMenuBarExtra: Binding<Bool>) {
        _showMenuBarExtra = showMenuBarExtra
    }
    
#if os(macOS)
    private let publisher = NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)
#else
    private let publisher = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
#endif
    
    var body: some View {
        VStack {
            Button(showMenuBarExtra ? "Switch to app" : "Switch to MenuBar") {
                showMenuBarExtra.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if showMenuBarExtra {
                        openWindow(id: "app")
                    } else {
                        dismissWindow(id: "app")
                    }
                }
            }
            .padding(.top)
            
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
            if showMenuBarExtra {
                dismissWindow(id: "app")
            }
            
            vm.listAvailableDisks()
        }
    }
}

#Preview {
    HomeView(.constant(true))
}
