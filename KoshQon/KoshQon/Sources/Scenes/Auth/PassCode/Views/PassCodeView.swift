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
    
    init(viewModel: PassCodeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Вв")
            PasscodeIndicatorView(passcode: $passcode)
                .shake($shake)
            NumberPadView(passcode: $passcode)
                .padding()
        }.onChange(of: passcode, perform: { value in
            verifyPasscode()
        })
    }
    
    private func verifyPasscode(){
        guard passcode.count == 4 else { return }
        
        Task{
            try? await Task.sleep(nanoseconds: 125_000_000)
            shake = passcode != "1111"
            passcode = ""
        }
    }
}

#Preview {
    PassCodeView(viewModel: PassCodeViewModel())
}
