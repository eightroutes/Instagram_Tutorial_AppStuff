//
//  EditProfileView.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/6/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        // @StateObject로 선언된 속성을 초기화할 때는 반드시 _viewModel과 같이 언더스코어를 통해 접근해야만 속성 래퍼에 직접 값을 할당할 수 있음
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
        
        
    }
    
    var body: some View {
        VStack {
            // toolbar(상단바)
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
//                        print("Update profile info")
                        Task { try await viewModel.updateUserData() }
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
                
                Divider() // 선
            }
            
            // edit profile pic
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .foregroundStyle(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    } else {
                        CircularProfileImageView(user: viewModel.user, size:.large)
                    }
                    
                    Text("Edit profile picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Divider()
                }

            }
            .padding(.vertical, 8)
            
            // edit profile info
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your name..", text: $viewModel.fullname)
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio..", text: $viewModel.bio)
            }
            
            Spacer()
            
        }
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextField(placeholder, text: $text)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}
