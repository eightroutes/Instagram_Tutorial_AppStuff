//
//  PostGridView.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/3/24.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    
    @StateObject var viewModel: PostGridViewModel
    

    init(user: User){
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
//    var posts: [Post] {
//        return Post.MOCK_POSTS.filter({$0.user?.username == user.username})
//    }
    
    // grid 변수 생성
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        
    ]
    
    private let imageDimension: CGFloat = UIScreen.main.bounds.width / 3 - 1

    var body: some View {
        // post grid view
        LazyVGrid(columns: gridItems, spacing: 1){
            ForEach(viewModel.posts){ post in
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
                
            }
            
        }
    }
}

#Preview {
    PostGridView(user: User.MOCK_USERS[0])
}
