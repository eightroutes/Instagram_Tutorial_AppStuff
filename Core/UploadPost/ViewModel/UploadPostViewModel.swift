//
//  UploadPostViewModel.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/3/24.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase
import FirebaseAuth

@MainActor // async에서 작동한것을 main thread로
class UploadPostViewModel: ObservableObject {
    // @Published -> 변화 시 view에게 알림 (ObeservableObject로 뷰 관찰)
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task{ await loadImage(fromItem: selectedImage)}}
    }
    
    @Published var postImage: Image?
    private var uiImage: UIImage?

    // 이미지 로드!
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        
        let postRef = Firestore.firestore().collection("posts").document()

        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, likes: 0, imageUrl: imageUrl, timestamp: Timestamp())
        
        // Firebase가 accept하려면 Encoding 필요!
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        
        try await postRef.setData(encodedPost)
        
    }
}
