import Foundation

enum MockError: Error {
    case decodingFailed
}

struct MockService {
    static func fetchUser() async throws -> User {
        // Deliberately bad JSON (wrong key)
        let json = """
        {
            "id": 1,
            "username": "Tesleem",
            "email": "tesleem@example.com"
        }
        """.data(using: .utf8)!

        // This will throw a decoding error
        return try JSONDecoder().decode(User.self, from: json)
    }
}
