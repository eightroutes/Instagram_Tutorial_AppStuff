//
//  ProfileView.swift
//  InstagramTutorial
//
//  Created by 정근호 on 9/30/24.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    
    var body: some View {
        // NavigationStack이 겹치면 안됨
//        NavigationStack {
            ScrollView {
                // header
                ProfileHeaderView(user: user)
                
                // post grid view
                PostGridView(user: user)
//            }
            
        }//ScrollView
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[3])
}
