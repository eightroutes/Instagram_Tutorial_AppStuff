//
//  AuthService.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/3/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService() // 싱글톤(uses same shared instance)
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor // UI를 다시 업데이트 하기 위해서는 MainThread로 돌아가야 함(Backgroudn - API 등 무거운 작업)
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            Task { try await loadUserData() } // 로그아웃하고 로그인 시 다시 loadUserData를 해서 reload data
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        //        print("Email is \(email)")
        //        print("Password is \(password)")
        //        print("Username is \(username)")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
//            print("DEBUG: Did crate user..")
            await self.uploadUserData(uid: result.user.uid, username: username, email: email)
//            print("DEBUG: Did upload user data..")
        } catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        // 로그인 시 현재 로그인된 사용자 정보 저장
        self.userSession = Auth.auth().currentUser
        guard let currentUid = self.userSession?.uid else { return } // 현재 유저 fetching
        self.currentUser = try await UserService.fetchUser(withUid: currentUid)
//        let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
////        print("DEBUG: Snapshot data is \(snapshot.data())")
//        self.currentUser = try? snapshot.data(as: User.self) // Decode
    }
    
    func signOut() {
        try? Auth.auth().signOut() // firebase signOut
        self.userSession = nil
        self.currentUser = nil
    }
    
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user
        // encoder를 사용해서 documentData(Firebase Dictionary)로 변형해야 firebase에 이용가능
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
