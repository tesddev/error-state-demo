import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading…")
            } else if let user = viewModel.user {
                VStack(spacing: 8) {
                    Text(user.name).font(.title2)
                    Text(user.email).foregroundStyle(.secondary)
                }
            } else {
                Text("No data")
            }
        }
        .task {
            await viewModel.loadUser()
        }
    }
}
