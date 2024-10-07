//
//  ContentView.swift
//  InstagramTutorial
//
//  Created by 정근호 on 9/30/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    
//    init() {
//        viewModel.userSession = nil
//    }
    
    var body: some View {
        Group{
            if viewModel.userSession == nil{
                LoginView()
                    .environmentObject(registrationViewModel)
            } else if let currentUser = viewModel.currentUser {
                MainTabView(user: currentUser)
            }
        }
    }
}

#Preview {
    ContentView()
}
