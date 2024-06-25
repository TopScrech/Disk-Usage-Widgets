import SwiftUI

struct HomeView: View {
    private var vm = VM()
    
    var body: some View {
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
    }
}

#Preview {
    HomeView()
}
