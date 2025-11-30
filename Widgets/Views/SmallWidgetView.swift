import SwiftUI
import WidgetKit

#warning("Implement new widget")
//struct SmallWidgetView: View {
//    private let entry: Provider.Entry
//
//    init(_ entry: Provider.Entry) {
//        self.entry = entry
//    }
//    
//    private var disk: DiskEntry? {
//        entry.disks.first
//    }
//    
//    private var name: String {
//        disk?.name ?? "Unknown"
//    }
//    
//    var body: some View {
//        VStack {
//            if let disk {
//                HStack {
//                    VStack {
//                        DiskName()
//                        
//                        Gauge(value: Double(disk.usedSpaceBytes), in: 0...Double(disk.totalSpaceBytes)) {
//                            Text(String(format: "%.0f%%", disk.usedSpaceBytes))
//                                .lineLimit(1)
//                                .scaledToFit()
//                                .minimumScaleFactor(0.5)
//                        }
//                        .gaugeStyle(.accessoryCircularCapacity)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    }
//                    
//                    VStack {
//                        DiskName()
//                        
//                        Gauge(value: Double(disk.usedSpaceBytes), in: 0...Double(disk.totalSpaceBytes)) {
//                            Text(String(format: "%.0f%%", disk.usedSpaceBytes))
//                                .lineLimit(1)
//                                .scaledToFit()
//                                .minimumScaleFactor(0.5)
//                        }
//                        .gaugeStyle(.accessoryCircularCapacity)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    }
//                }
//                
//                HStack {
//                    VStack {
//                        Gauge(value: Double(disk.usedSpaceBytes), in: 0...Double(disk.totalSpaceBytes)) {
//                            Text(String(format: "%.0f %", disk.usedSpaceBytes))
//                                .lineLimit(1)
//                                .scaledToFit()
//                                .minimumScaleFactor(0.5)
//                        }
//                        .gaugeStyle(.accessoryCircularCapacity)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        
//                        DiskName()
//                    }
//                    
//                    VStack {
//                        Gauge(value: Double(disk.usedSpaceBytes), in: 0...Double(disk.totalSpaceBytes)) {
//                            Text(disk.freeSpacePercentage)
//                                .lineLimit(1)
//                                .scaledToFit()
//                                .minimumScaleFactor(0.5)
//                        }
//                        .gaugeStyle(.accessoryCircularCapacity)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        
//                        DiskName()
//                    }
//                }
//            }
//        }
//        .overlay {
//            if entry.config.showRefreshButton {
//                Button(intent: RefreshIntent()) {
//                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
//                        .caption2()
//                }
//                .clipShape(.circle)
//            }
//        }
//        .overlay(alignment: .leading) {
//            VStack(alignment: .trailing) {
//                if entry.config.showRefreshTime {
//                    Text(entry.date, format: .dateTime.hour().minute().second())
//                }
//                
//                if entry.config.showBuildNumber {
//                    Text("B\(Utils.buildNumber)")
//                }
//            }
//            .caption2()
//            .tertiary()
//            .offset(y: -28)
//            .rotate(-90)
//        }
//    }
//    
//    private func DiskName() -> some View {
//        Text(name)
//            .caption2()
//            .secondary()
//            .lineLimit(1)
//    }
//}
//
//#Preview(as: .systemSmall) {
//    DiskUsageWidget()
//} timeline: {
//    SimpleEntry(date: Date(), config: .init(), disks: [Utils.previewDisk])
//}
