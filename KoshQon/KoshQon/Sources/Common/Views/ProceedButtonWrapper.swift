//
//  ProceedButtonWrapper.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.06.2024.
//

import SwiftUI

struct ProceedButtonWrapper: UIViewRepresentable {
    
    let type: ProceedButtonType
    
    func makeUIView(context: Context) -> ProceedButton {
        let button = ProceedButton()
        button.type = type
        button.layer.cornerRadius = button.frame.height / 2
        return button
    }
    
    func updateUIView(_ uiView: ProceedButton, context: Context) {
        uiView.type = type
    }
}
