//
//  SearchView.swift
//  InstagramTutorial
//
//  Created by 정근호 on 9/30/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12){
                    ForEach(viewModel.users) { user in
                        // value based -> .navigationDestination
                        NavigationLink(value: user) {
                            HStack {
                                CircularProfileImageView(user: user, size: .xSmall)
                                VStack(alignment: .leading) {
                                    Text(user.username)
                                        .fontWeight(.semibold)
                                    
                                    if let fn = user.fullname{
                                        Text(fn)
                                    }
                                }
                                .font(.footnote)
                                Spacer()
                            }
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                        }
                    }//ForEach User
                }//LazyVStack
                .padding(.top, 8)
                // 검색 바
                .searchable(text: $searchText, prompt: "Search...")
            }//ScrollView
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }//NavigationStack
        .tint(.black)
    }
}


#Preview {
    SearchView()
}
