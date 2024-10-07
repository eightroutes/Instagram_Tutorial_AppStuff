//
//  User.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/2/24.
//

import Foundation
import FirebaseAuth

// Codable - encoding
struct User: Identifiable, Codable, Hashable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

// 가짜 유저 목록
extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "Venom", profileImageUrl: nil, fullname: "Eddie Brock", bio: "Delicious!", email: "venom@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Black Panther", profileImageUrl: nil, fullname: "Chadwick Boseman", bio: "Wakanda Forever", email: "blackpanther@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Iron Man", profileImageUrl: nil, fullname: "Tony Stark", bio: "Money!", email: "ironman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Spider Man", profileImageUrl: nil, fullname: "Peter Parker", bio: "Web", email: "spider@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Doctor Doom", profileImageUrl: nil, fullname: nil, bio: "Haha", email: "doom@gmail.com"),
    ]
}
