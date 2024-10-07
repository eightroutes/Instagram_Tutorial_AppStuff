//
//  PostService.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/6/24.
//

import Foundation
import Firebase

struct PostService {
    
    private static let postsCollection = Firestore.firestore().collection("posts")
    
    static func fetchFeedPosts() async throws -> [Post] {
        let snapshot = try await postsCollection.getDocuments()
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        //        self.posts = try snapshot.documents.compactMap({ document in
        //            let post = try document.data(as: Post.self)
        //            return post
        //        })
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        
        return posts
        
    }
    
    // 탭바 프로필 창에 뜨는 유저 포스트들
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
}
