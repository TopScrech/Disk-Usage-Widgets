import ScrechKit

struct StorageOverviewView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(StorageVM.self) private var vm
    
    var body: some View {
        ScrollView {
            if let snapshot = vm.snapshot {
                VStack {
                    if horizontalSizeClass == .regular {
                        HStack {
                            StorageGaugeView(snapshot: snapshot)
                            CapacitySummaryView(snapshot)
                        }
                    } else {
                        VStack {
                            StorageGaugeView(snapshot: snapshot)
                            CapacitySummaryView(snapshot)
                        }
                    }
                    
                    CapacityBreakdownView(snapshot: snapshot)
                    ExternalDrivesView()
                    StorageStatusView(snapshot: snapshot)
                    WidgetInstructionsView()
                }
                .padding()
            } else if let errorMessage = vm.errorMessage {
                StorageUnavailableView(
                    message: errorMessage,
                    retryAction: vm.refresh
                )
            } else {
                ProgressView("Reading storage…")
                    .containerRelativeFrame([.horizontal, .vertical])
            }
        }
        .background(.gray.opacity(0.08))
        .refreshable {
            vm.refresh()
        }
    }
}

#Preview {
    NavigationStack {
        StorageOverviewView()
            .environment(StorageVM())
    }
}
