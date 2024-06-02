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
                
                RoundedBlock(title: LocalizableKeys.AddAnnouncement.residencePlace.localized()) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.selectedImages.indices, id: \.self) { index in
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: viewModel.selectedImages[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: (UIScreen.main.bounds.width - 48 - CGFloat(columns.count - 1) * 16) / CGFloat(columns.count), height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Button(action: {
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
                                showImagePicker.toggle()
                            }) {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(AppColor.Theme.separation.swiftUIColor, lineWidth: 1)
                                        .frame(width: (UIScreen.main.bounds.width - 48 - CGFloat(columns.count - 1) * 16) / CGFloat(columns.count), height: 100)
                                    
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
                    
                    InputTextFieldWrapper(text: $viewModel.appartmentType, inputType: .apartmentType)
                    
                    HStack {
                        InputTextFieldWrapper(text: $viewModel.roomNumber, inputType: .regular, placeholder: LocalizableKeys.AddAnnouncement.roomNumber.localized(), keyboardType: .numberPad)
                        
                        InputTextFieldWrapper(text: $viewModel.area, inputType: .regular, placeholder: LocalizableKeys.AddAnnouncement.area.localized(), keyboardType: .numberPad)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(LocalizableKeys.AddAnnouncement.floor.localized())
                            .font(AppFont.medium.s16.swiftUIFont)
                        
                        HStack {
                            InputTextFieldWrapper(text: $viewModel.floor1, inputType: .regular, keyboardType: .numberPad)
                            
                            Text(LocalizableKeys.AddAnnouncement.of.localized())
                                .font(AppFont.medium.s16.swiftUIFont)
                            
                            InputTextFieldWrapper(text:$viewModel.floor2, inputType: .regular, keyboardType: .numberPad)
                        }
                    }
                    .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                    
                    InputTextFieldWrapper(text: $viewModel.condition, inputType: .condition)
                    
                    HStack {
                        Text(LocalizableKeys.AddAnnouncement.internet.localized())
                            .font(AppFont.medium.s16.swiftUIFont)
                        
                        Spacer()
                        
                        HStack {
                            CheckboxView(isChecked: $viewModel.isInternet)
                            
                            Text(LocalizableKeys.AddAnnouncement.est.localized())
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                    
                    InputTextFieldWrapper(text: $viewModel.sanuzel, inputType: .sanuzel)
                    
                }
                
                RoundedBlock(title: LocalizableKeys.AddAnnouncement.location.localized()) {
                    InputTextFieldWrapper(text: $viewModel.city, inputType: .city)
                    
                    InputTextFieldWrapper(text: $viewModel.district, inputType: .district)
                    
                    HStack {
                        InputTextFieldWrapper(text: $viewModel.street, inputType: .regular, placeholder: LocalizableKeys.AddAnnouncement.street.localized())
                        
                        InputTextFieldWrapper(text: $viewModel.houseNumber, inputType: .regular, placeholder: LocalizableKeys.AddAnnouncement.houseNumber.localized(), keyboardType: .numberPad)
                    }
                }
                
                RoundedBlock(title: LocalizableKeys.AddAnnouncement.rommateChar.localized()) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(LocalizableKeys.AddAnnouncement.age.localized())
                            .font(AppFont.medium.s16.swiftUIFont)
                        
                        HStack {
                            InputTextFieldWrapper(text: $viewModel.age1, inputType: .regular, keyboardType: .numberPad)
                            
                            Text(" - ")
                                .font(AppFont.medium.s16.swiftUIFont)
                            
                            InputTextFieldWrapper(text: $viewModel.age2, inputType: .regular, keyboardType: .numberPad)
                        }
                    }
                    .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                    
                    InputTextFieldWrapper(text: $viewModel.gender, inputType: .gender)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(LocalizableKeys.AddAnnouncement.budget.localized()) (₸)")
                            .font(AppFont.medium.s16.swiftUIFont)
                        
                        HStack {
                            InputTextFieldWrapper(text: $viewModel.budget1, inputType: .regular, keyboardType: .numberPad)
                            
                            Text(" - ")
                                .font(AppFont.medium.s16.swiftUIFont)
                            
                            InputTextFieldWrapper(text: $viewModel.budget2, inputType: .regular, keyboardType: .numberPad)
                            
                        }
                    }
                    .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(LocalizableKeys.AddAnnouncement.description.localized())
                            .font(AppFont.medium.s16.swiftUIFont)
                        
                        DynamicTextEditor(text: $viewModel.description)
                    }
                    .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                }
                
                Button {
                    viewModel.createAnnouncement()
                } label: {
                    VStack {
                        ProceedButtonWrapper(type: .create)
                    }
                    .frame(height: 50)
                    .cornerRadius(25)
                }
                
            }
            .padding(.bottom, 32)
            .padding(.top)
            .padding(.horizontal)
        }
    }
}
