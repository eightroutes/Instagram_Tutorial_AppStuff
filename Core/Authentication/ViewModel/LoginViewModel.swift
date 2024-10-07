//
//  LoginViewModel.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/4/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
