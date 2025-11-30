import ScrechKit

enum Utils {    
    static var buildNumber: String {
        Bundle.build ?? "Unknown"
    }
}
