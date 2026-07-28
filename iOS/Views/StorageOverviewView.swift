import ScrechKit

struct StorageOverviewView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(StorageVM.self) private var viewModel

    var body: some View {
        ScrollView {
            if let snapshot = viewModel.snapshot {
                VStack {
                    if horizontalSizeClass == .regular {
                        HStack {
                            StorageGaugeView(snapshot: snapshot)
                            CapacitySummaryView(snapshot: snapshot)
                        }
                    } else {
                        VStack {
                            StorageGaugeView(snapshot: snapshot)
                            CapacitySummaryView(snapshot: snapshot)
                        }
                    }

                    CapacityBreakdownView(snapshot: snapshot)
                    StorageStatusView(snapshot: snapshot)
                    WidgetInstructionsView()
                }
                .padding()
            } else if let errorMessage = viewModel.errorMessage {
                StorageUnavailableView(
                    message: errorMessage,
                    retryAction: viewModel.refresh
                )
            } else {
                ProgressView("Reading storage…")
                    .containerRelativeFrame([.horizontal, .vertical])
            }
        }
        .background(.gray.opacity(0.08))
        .refreshable {
            viewModel.refresh()
        }
    }
}

#Preview {
    NavigationStack {
        StorageOverviewView()
            .environment(StorageVM())
    }
}
