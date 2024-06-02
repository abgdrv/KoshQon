//
//  DynamicTextEditor.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.06.2024.
//

import SwiftUI

struct DynamicTextEditor: View {
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .frame(height: 100)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(AppColor.Theme.separation.swiftUIColor, lineWidth: 1)
                }
        }
    }
}
