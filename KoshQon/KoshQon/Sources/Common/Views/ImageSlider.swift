//
//  ImageSlider.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 02.06.2024.
//

import SwiftUI

struct ImageSlider: View {
    
    let images: [UIImage?]
    @State private var currentPage = 0 // Changed to @State
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(images.indices, id: \.self) { index in // Use indices for currentPage binding
                    images[index]?.swiftUIImage
                        .resizable()
                        .scaledToFill()
                        .tag(index) // Use index as tag for selection
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Ensure the dots are displayed
        }
        .cornerRadius(10)
    }
}
