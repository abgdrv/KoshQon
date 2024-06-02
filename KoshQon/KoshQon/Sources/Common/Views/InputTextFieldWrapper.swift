//
//  InputTextFieldWrapper.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 29.05.2024.
//

import SwiftUI

struct InputTextFieldWrapper: UIViewRepresentable {
    
    @Binding var text: String
    
    let inputType: InputType
    let placeholder: String?
    let keyboardType: UIKeyboardType?
    
    init(text: Binding<String>, inputType: InputType, placeholder: String? = nil, keyboardType: UIKeyboardType? = nil) {
        self._text = text
        self.inputType = inputType
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }

    func makeUIView(context: Context) -> InputTextField {
        let textField = InputTextField(inputType: inputType, placeholder: placeholder, _keyboardType: keyboardType)
        textField.layer.cornerRadius = 8
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
        textField.didSelect = { title in
            text = title
        }
        return textField
    }
    
    func updateUIView(_ uiView: InputTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}
