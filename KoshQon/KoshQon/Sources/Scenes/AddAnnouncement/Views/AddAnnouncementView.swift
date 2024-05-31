//
//  AddAnnouncementView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import SwiftUI

struct AddAnnouncementView: View {
    
    @ObservedObject var viewModel: AddAnnouncementViewModel
    
    @State private var showImagePicker: Bool = false
    
    private let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(LocalizableKeys.NavigationBar.add.localized())
                        .font(AppFont.medium.s24.swiftUIFont)
                    
                    Text(LocalizableKeys.AddAnnouncement.newAnnouncement.localized())
                        .font(AppFont.medium.s16.swiftUIFont)
                }
                .foregroundStyle(AppColor.Theme.mainTitle.swiftUIColor)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(LocalizableKeys.AddAnnouncement.residencePlace.localized())
                        .font(AppFont.medium.s20.swiftUIFont)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.selectedImages.indices, id: \.self) { index in
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: viewModel.selectedImages[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: (UIScreen.main.bounds.width - 48) / 2, height: 100) // Rectangular frame, 2 items in a row
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Button(action: {
                                    // Delete the selected image
                                    viewModel.selectedImages.remove(at: index)
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(Color.red)
                                        .padding(5)
                                        .background(AppColor.Theme.mainBackground.swiftUIColor)
                                        .clipShape(Circle())
                                        .offset(x: 10, y: -10)
                                }
                                .opacity($viewModel.selectedImages.isEmpty ? 0 : 1)
                            }
                        }
                        
                        if viewModel.selectedImages.count < 9 {
                            Button(action: {
                                // Toggle the image picker
                                showImagePicker.toggle()
                            }) {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(AppColor.Theme.separation.swiftUIColor, lineWidth: 1)
                                        .frame(width: (UIScreen.main.bounds.width - 48) / 2, height: 100)
                                    
                                    VStack(spacing: 5) {
                                        Image(systemName: "plus")
                                        
                                        Text(LocalizableKeys.AddAnnouncement.addPhoto.localized())
                                    }
                                    .foregroundColor(AppColor.Static.darkBlue.swiftUIColor)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(selectedImages: $viewModel.selectedImages)
                            }
                        }
                    }
                }
                
                RoundedBlock(title: "Aдрес") {
                    InputTextFieldWrapper(text: .constant(""), inputType: .city)
                }
                
                
                Spacer()
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea(.keyboard)
    }
}
