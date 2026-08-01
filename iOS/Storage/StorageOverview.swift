import ScrechKit

struct StorageOverview: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(StorageVM.self) private var vm
    
    var body: some View {
        ScrollView {
            if let snapshot = vm.snapshot {
                VStack {
                    StorageStatusView(snapshot: snapshot)

                    if horizontalSizeClass == .regular {
                        HStack {
                            StorageGauge(snapshot: snapshot)
                            CapacitySummaryView(snapshot)
                        }
                    } else {
                        VStack {
                            StorageGauge(snapshot: snapshot)
                                .padding(.vertical)
                            
                            CapacitySummaryView(snapshot)
                        }
                    }
                    
                    ExternalDriveList()
                    WidgetInstructionsView()
                }
                .padding()
            } else if let errorMessage = vm.errorMessage {
                StorageUnavailableView(message: errorMessage, retryAction: vm.refresh)
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
        StorageOverview()
            .environment(StorageVM())
    }
}
