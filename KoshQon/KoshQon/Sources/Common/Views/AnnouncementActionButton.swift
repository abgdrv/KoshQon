//
//  AnnouncementActionButton.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 02.06.2024.
//

import SwiftUI

struct AnnouncementActionButton: View {
    
    @Binding var isSelected: Bool
    
    private let image: Image
    private let selectedImage: Image
    
    private let action: Callback<Bool>
    
    init(isSelected: Binding<Bool>, image: Image, selectedImage: Image, action: @escaping Callback<Bool>) {
        self._isSelected = isSelected
        self.image = image
        self.selectedImage = selectedImage
        self.action = action
    }
    
    var body: some View {
        Button {
            isSelected.toggle()
            action(isSelected)
        } label: {
            isSelected ? selectedImage : image
        }
    }
}
