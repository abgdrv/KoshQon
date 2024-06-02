//
//  CheckboxView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.06.2024.
//

import SwiftUI

struct CheckboxView: View {
    
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            isChecked ? AppImage.Common.checkboxSelected.swiftUIImage : AppImage.Common.checkbox.swiftUIImage
        }
    }
}
