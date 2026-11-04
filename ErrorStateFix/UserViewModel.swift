import Foundation
import Combine

@MainActor
final class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var loadTask: Task<Void, Never>?
    
    func loadUser() {
        Task {
            loadTask?.cancel()
            user = nil
            isLoading = true
            errorMessage = nil
            
            do {
                user = try await MockService.fetchUser()
                isLoading = false          // only clear on success
            } catch is CancellationError {
                
            } catch {
                isLoading = false
                errorMessage = "Failed to load user. Please try again!"
                // Bug: error is swallowed and loading is never cleared
                print("Failed:", error)
                // isLoading stays true → endless spinner
            }
        }
    }
    
    func retry() {
        loadUser()
    }
    
}
