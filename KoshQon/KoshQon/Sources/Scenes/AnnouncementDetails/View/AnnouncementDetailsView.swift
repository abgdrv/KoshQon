//
//  AnnouncementDetailsView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 02.06.2024.
//

import SwiftUI

struct AnnouncementDetailsView: View {
    
    @ObservedObject var viewModel: AnnouncementDetailsViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    if viewModel.announcement.user.id != AppData.shared.user.id {
                        Text(LocalizableKeys.AnnouncementDetails.author.localized())
                            .font(AppFont.medium.s20.swiftUIFont)
                            .foregroundColor(AppColor.Theme.mainTitle.swiftUIColor)
                        
                        HStack(spacing: 16) {
                            viewModel.announcement.user.image?.swiftUIImage
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(viewModel.announcement.user.fullName)
                                    .font(AppFont.medium.s20.swiftUIFont)
                                    .foregroundColor(AppColor.Theme.mainTitle.swiftUIColor)
                                
                                Text(viewModel.announcement.user.address)
                                    .font(AppFont.medium.s12.swiftUIFont)
                                    .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                                
                                Text(viewModel.announcement.user.age.age)
                                    .font(AppFont.medium.s12.swiftUIFont)
                                    .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                                
                                Spacer()
                            
                                Button {
                                    viewModel.didProfileTap?(viewModel.announcement.user)
                                } label: {
                                    Text(LocalizableKeys.AnnouncementDetails.goToPage.localized())
                                        .font(AppFont.medium.s14.swiftUIFont)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                        .foregroundColor(AppColor.Static.white.swiftUIColor)
                                }
                                .frame(maxWidth: .infinity)
                                .background(AppColor.Static.orange.swiftUIColor)
                                .cornerRadius(20)
                            }
                        }
                        
                        HStack(spacing: 16) {
                            Spacer()
                            
                            AnnouncementActionButton(isSelected: $viewModel.isFavorite, image: AppImage.Common.heart.swiftUIImage, selectedImage: AppImage.Common.heartFill.swiftUIImage) { isSelected in
                                if isSelected {
                                    AppData.shared.favorites.insert(viewModel.announcement, at: 0)
                                } else {
                                    if let index = AppData.shared.favorites.firstIndex(of: viewModel.announcement) {
                                        AppData.shared.favorites.remove(at: index)
                                    }
                                }
                            }
                            
                            AnnouncementActionButton(isSelected: .constant(false), image: AppImage.Common.share.swiftUIImage, selectedImage: AppImage.Common.share.swiftUIImage) { isSelected in
                                let activityViewController = UIActivityViewController(activityItems: ["http://localhost:8000/announcements/\(viewModel.announcement.id)"], applicationActivities: nil)
                                
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let viewController = windowScene.windows.first?.rootViewController {
                                    viewController.present(activityViewController, animated: true, completion: nil)
                                }
                            }
                            
                            AnnouncementActionButton(isSelected: .constant(false), image: AppImage.Common.report.swiftUIImage, selectedImage: AppImage.Common.report.swiftUIImage) { isSelected in
                                
                            }
                        }
                        
                        VStack {
                            Text(LocalizableKeys.AnnouncementDetails.reportMessage.localized())
                                .font(AppFont.medium.s10.swiftUIFont)
                                .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                                .padding()
                        }
                        .background(AppColor.Static.lightRed.swiftUIColor.opacity(0.15))
                        .cornerRadius(10)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text(LocalizableKeys.AddAnnouncement.residencePlace.localized())
                                .font(AppFont.medium.s20.swiftUIFont)
                                .foregroundColor(AppColor.Theme.mainTitle.swiftUIColor)
                            
                            if !viewModel.announcement.images.isEmpty {
                                ImageSlider(images: viewModel.announcement.images)
                                    .frame(height: 220)
                            }
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(LocalizableKeys.Helpers.city.localized())
                                    
                                    Text(LocalizableKeys.Helpers.district.localized())
                                    
                                    Text(LocalizableKeys.Helpers.apartmentType.localized())
                                    
                                    Text(LocalizableKeys.AddAnnouncement.roomNumber.localized())
                                    
                                    Text(LocalizableKeys.AddAnnouncement.area.localized())
                                    
                                    Text(LocalizableKeys.AddAnnouncement.floor.localized())
                                    
                                    Text(LocalizableKeys.Helpers.condition.localized())
                                    
                                    Text(LocalizableKeys.Helpers.sanuzel.localized())
                                    
                                    Text(LocalizableKeys.AddAnnouncement.internet.localized())
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(viewModel.announcement.city)
                                    
                                    Text(viewModel.announcement.district)
                                    
                                    Text(viewModel.announcement.type)
                                    
                                    Text(viewModel.announcement.rooms)
                                    
                                    Text(viewModel.announcement.area)
                                    
                                    Text(viewModel.announcement.floorString)
                                    
                                    Text(viewModel.announcement.condition)
                                    
                                    Text(viewModel.announcement.sanuzel)
                                    
                                    Text(viewModel.announcement.isInternet
                                         ? LocalizableKeys.AddAnnouncement.est.localized()
                                         : "-")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .font(AppFont.regular.s16.swiftUIFont)
                            .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text(LocalizableKeys.AddAnnouncement.rommateChar.localized())
                                .font(AppFont.medium.s20.swiftUIFont)
                                .foregroundColor(AppColor.Theme.mainTitle.swiftUIColor)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(LocalizableKeys.AddAnnouncement.age.localized())
                                    
                                    Text(LocalizableKeys.Helpers.gender.localized())
                                    
                                    Text(LocalizableKeys.AddAnnouncement.budget.localized())
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(viewModel.announcement.ageString)
                                    
                                    Text(viewModel.announcement.gender)
                                    
                                    Text(viewModel.announcement.budgetString)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .font(AppFont.regular.s16.swiftUIFont)
                            .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                        }
                        
                        if !viewModel.announcement.description.isEmpty {
                            VStack(alignment: .leading, spacing: 16) {
                                Text(LocalizableKeys.AddAnnouncement.description.localized())
                                    .font(AppFont.medium.s20.swiftUIFont)
                                    .foregroundColor(AppColor.Theme.mainTitle.swiftUIColor)
                                
                                Text(viewModel.announcement.description)
                                    .font(AppFont.regular.s14.swiftUIFont)
                                    .foregroundColor(AppColor.Static.darkGray.swiftUIColor)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            if viewModel.announcement.user.id != AppData.shared.user.id {
                buttons
                    .padding(.bottom)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
    
    var buttons: some View {
        HStack(spacing: 8) {
            Button(action: {
                // Action for the first button
            }) {
                VStack {
                    Text(LocalizableKeys.ActionButton.write.localized())
                        .foregroundColor(AppColor.Static.white.swiftUIColor) // Set text color to white
                        .padding() // Add padding for better appearance
                }
                .frame(maxWidth: .infinity)
            }
            .background(AppColor.Static.darkBlue.swiftUIColor) // Set background color to blue
            .cornerRadius(8)
            
            Button(action: {
                viewModel.call()
            }) {
                VStack {
                    Text(LocalizableKeys.ActionButton.call.localized())
                        .foregroundColor(AppColor.Static.white.swiftUIColor) // Set text color to white
                        .padding() // Add padding for better appearance
                }
                .frame(maxWidth: .infinity)
            }
            .background(AppColor.Static.green.swiftUIColor) // Set background color to green
            .cornerRadius(8) // Apply corner radius for rounded appearance
        }
    }
}
