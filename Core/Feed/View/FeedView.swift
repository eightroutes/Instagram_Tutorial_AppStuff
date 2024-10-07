//
//  FeedView.swift
//  InstagramTutorial
//
//  Created by 정근호 on 9/30/24.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack(spacing: 32) {
                    ForEach (viewModel.posts) { post in
                        FeedCell(post: post)
                        
                    }
                }
                .padding(.top, 8)
                
            }//ScrollView
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("instagram-removebg-preview")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 90)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                }
            }
        }
    }
}

#Preview {
    FeedView()
}
