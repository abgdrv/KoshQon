//
//  NumberView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.04.2024.
//

import SwiftUI

struct NumberView: View {
    
    let number: Int
    var onAction: Callback<Int>?
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(uiColor: AppColor.Theme.mainTitle.uiColor))
                .foregroundStyle(.clear)
                .padding()
            Button {
                onAction?(number)
            } label:{
                if number == 10 {
                    Image(systemName: "delete.backward")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,16)
                        .contentShape(.rect)
                } else {
                    Text("\(number)")
                        .font(Font(AppFont.medium.s40))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .contentShape(.rect)
                }
            }
        }
    }
}
