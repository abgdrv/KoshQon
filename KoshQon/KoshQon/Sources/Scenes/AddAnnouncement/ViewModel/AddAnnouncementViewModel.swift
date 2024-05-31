//
//  AddAnnouncementViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import SwiftUI
import Combine

final class AddAnnouncementViewModel: ObservableObject {
    
    @Published var selectedImages: [UIImage] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $selectedImages
            .receive(on: DispatchQueue.main)
            .sink { _ in
                // Do any additional processing if needed
            }
            .store(in: &cancellables)
    }
    
}

