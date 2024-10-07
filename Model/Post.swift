//
//  Post.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/2/24.
//

import Foundation
import Firebase

// Identifiable - ForEach 이용해 리스트로 표현가능
// Hashable - navigatable 하게끔(navigationDestination)
// Codable - up/download to server

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp // Firebase는 Date object를 지원하지 않음, custom timestamp 필요
    var user: User?
}

// static으로 정의된 프로퍼티나 메서드는 타입 자체에 속하며, 인스턴스와는 독립적
extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Test Caption", likes: 10, imageUrl: "images (4)", timestamp: Timestamp(), user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Wakanda", likes: 12, imageUrl: "images (1)", timestamp: Timestamp(), user: User.MOCK_USERS[1]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "MARK", likes: 20, imageUrl: "images (7)", timestamp: Timestamp(), user: User.MOCK_USERS[2]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Spider", likes: 19, imageUrl: "images (9)", timestamp: Timestamp(), user: User.MOCK_USERS[3]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "DOOM", likes: 31, imageUrl: "images (8)", timestamp: Timestamp(), user: User.MOCK_USERS[4]),
    ]
}
