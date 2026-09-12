import SwiftUI
import WidgetKit

struct HomeViewToolbar: View {
    @Environment(VM.self) private var vm
    
    var body: some View {
        Button {
            refresh()
        } label: {
            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                .bold()
        }
        .keyboardShortcut("r")
        .help("⌘ R to refresh")
    }
    
    private func refresh() {
        vm.listAvailableDisks()
        WidgetCenter.shared.reloadAllTimelines()
    }
}

#Preview {
    HomeViewToolbar()
        .darkSchemePreferred()
        .environment(VM())
}
