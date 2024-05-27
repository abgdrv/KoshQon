//
//  AddAnnouncementView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import SwiftUI
import PhotosUI

struct AddAnnouncementView: View {
    
    @ObservedObject var viewModel: AddAnnouncementViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Подать")
                        .font(AppFont.medium.s24.swiftUIFont)
                    
                    Text("Новое объявление")
                        .font(AppFont.medium.s16.swiftUIFont)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(AppColor.Theme.mainTitle.swiftUIColor)
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(.keyboard)
    }
}
