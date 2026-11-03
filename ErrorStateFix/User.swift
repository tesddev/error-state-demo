import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    // Bug: JSON will contain "username" instead of "name"
}
