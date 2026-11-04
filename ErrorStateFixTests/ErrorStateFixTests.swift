//
//  ErrorStateFixTests.swift
//  ErrorStateFixTests
//
//  Created by Tes on 02/11/2026.
//

import Testing
@testable import ErrorStateFix

struct ErrorStateFixTests {

    @Test @MainActor func decodingFailureSetsErrorMessage() async throws {
        let viewModel = UserViewModel()
        viewModel.loadUser()
        
        //Give the task a moment to fail
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.user == nil)
    }
    
    @Test @MainActor func retryCancelsPreviousTask() async throws {
        let viewModel = UserViewModel()
        viewModel.loadUser()
        viewModel.retry()
        
        //Give the task a moment to fail
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(viewModel.isLoading == false)
    }

}
