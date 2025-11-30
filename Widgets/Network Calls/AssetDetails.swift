struct UsageAttributes: Codable {
    let memory: Double
    let cpu: Double
    let disk: Double
}

struct AssetDetails: Codable {
    let state: String
    var usage: UsageAttributes? = nil
}
