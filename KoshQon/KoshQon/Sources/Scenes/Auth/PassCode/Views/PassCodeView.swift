//
//  PassCodeView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.04.2024.
//

import SwiftUI

struct PassCodeView: View {
    
    @State private var passcode = ""
    @State private var shake = false
    
    private let viewModel: PassCodeViewModel
    
    var passwordDidEnter: Callback<Bool>?
        
    init(viewModel: PassCodeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 50) {
            Text(viewModel.title)
            PasscodeIndicatorView(passcode: $passcode)
                .shake($shake)
            NumberPadView(passcode: $passcode)
                .padding()
        }.onChange(of: passcode, perform: { value in
            submitPasscode()
        })
    }
    
    private func submitPasscode() {
        guard passcode.count == 4 else { return }
        
        Task {
            try? await Task.sleep(nanoseconds: 125_000_000)
            shake = viewModel.checkPasscode(code: passcode)
            viewModel.submitPasscode(code: passcode) { isVerify in 
                DispatchQueue.main.async {
                    self.passwordDidEnter?(isVerify)
                }
            }
            passcode = ""
        }
    }
}
