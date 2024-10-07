//
//  IGTextFieldModifier.swift
//  InstagramTutorial
//
//  Created by 정근호 on 10/2/24.
//

import Foundation
import SwiftUI

// View안의 요소들의 설정들을 한번에 간편하게 수정
struct IGTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}
