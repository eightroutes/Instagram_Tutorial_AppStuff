//
//  EditProfileViewModel.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/6/24.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    // @Published -> 변화 시 view에게 알림 (ObeservableObject로 뷰 관찰)
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task{ await loadImage(fromItem: selectedImage)}}
    }
    @Published var profileImage: Image?
    
    @Published var fullname = ""
    @Published var bio = ""
    
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    // 이미지 로드!
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        // update profile image if changed
        
        var data = [String : Any]() // () call
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        // update name if changed
        if !fullname.isEmpty && user.fullname != fullname {
//            print("DEBUG: Update fullname \(fullname)")
            user.fullname = fullname
            data["fullname"] = fullname
        }
        
        // update bio if changed
        if !bio.isEmpty && user.bio != bio {
//            print("DEBUG: Update bio \(bio)")
            user.bio = bio
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            // "users" collection의 documents 업데이트
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
        
        
    }
}
