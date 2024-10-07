//
//  FeedViewModel.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/6/24.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]() // () -> 초기화를 의미
    
    init() {
        Task { try await fetchPosts() }
    }
    
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchFeedPosts()
    }
}
