import Foundation
import Combine

@MainActor
final class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadUser() async {
        isLoading = true
        errorMessage = nil
        
        do {
            user = try await MockService.fetchUser()
            isLoading = false          // only clear on success
        } catch {
            // Bug: error is swallowed and loading is never cleared
            print("Failed:", error)
            // isLoading stays true → endless spinner
        }
    }
    
}
