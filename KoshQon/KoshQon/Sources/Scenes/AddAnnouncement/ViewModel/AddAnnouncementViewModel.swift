//
//  AddAnnouncementViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import SwiftUI
import Combine
import ProgressHUD

final class AddAnnouncementViewModel: ObservableObject {
    
    @Published var selectedImages: [UIImage] = []
    
    @Published var appartmentType: String = ""
    @Published var roomNumber: String = ""
    @Published var area: String = ""
    @Published var floor1: String = ""
    @Published var floor2: String = ""
    @Published var condition: String = ""
    @Published var isInternet: Bool = false
    @Published var sanuzel: String = ""
    @Published var city: String = ""
    @Published var district: String = ""
    @Published var street: String = ""
    @Published var houseNumber: String = ""
    @Published var age1: String = ""
    @Published var age2: String = ""
    @Published var gender: String = ""
    @Published var budget1: String = ""
    @Published var budget2: String = ""
    @Published var description: String = ""
    
    var didCreate: VoidCallback?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $selectedImages
            .receive(on: DispatchQueue.main)
            .sink { _ in
                // Do any additional processing if needed
            }
            .store(in: &cancellables)
    }
    
    func createAnnouncement() {
        guard !appartmentType.isEmpty,
              !roomNumber.isEmpty,
              !area.isEmpty,
              !floor1.isEmpty,
              !floor2.isEmpty,
              !condition.isEmpty,
              !sanuzel.isEmpty,
              !city.isEmpty,
              !district.isEmpty,
              !street.isEmpty,
              !houseNumber.isEmpty,
              !age1.isEmpty,
              !age2.isEmpty,
              !gender.isEmpty,
              !budget1.isEmpty,
              !budget2.isEmpty else {
            ProgressHUD.banner(LocalizableKeys.Alert.error.localized(), LocalizableKeys.Alert.emptyFields.localized(), delay: 3)
            return
        }
        
        var announcement = Announcement(
            user: AppData.shared.user,
            type: appartmentType,
            city: city,
            district: district,
            street: street,
            houseNumber: houseNumber,
            rooms: roomNumber,
            area: area,
            floor: (floor1, floor2),
            sanuzel: sanuzel,
            condition: condition,
            isInternet: isInternet,
            description: description,
            age: (age1, age2),
            gender: gender,
            budget: (budget1, budget2)
        )
        
        if !selectedImages.isEmpty {
            announcement.images = selectedImages
        }
        
        AppData.shared.announcements.insert(announcement, at: 0)
        didCreate?()
    }
    
}

