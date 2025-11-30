import AppIntents

struct DiskIntentTypeAppEntity: AppEntity {
    static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "Disk")
    static let defaultQuery = DiskIntentTypeAppEntityQuery()
    
    var id: String
    var displayString: String
    var subtitle: String?
    
    init(id: String, displayString: String, subtitle: String? = nil) {
        self.id = id
        self.displayString = displayString
        self.subtitle = subtitle
    }
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: LocalizedStringResource(stringLiteral: displayString),
            subtitle: subtitle.map {
                LocalizedStringResource(stringLiteral: $0)
            }
        )
    }
}
