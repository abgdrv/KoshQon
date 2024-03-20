//
//  SignInViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 21.02.2024.
//

import Foundation

protocol SignInProtocol {
    func signIn(signInModel: SignInModel)
}

final class SignInViewModel: SignInProtocol {
    
    // MARK: - Properties
    
    private var model: SignInModel?
    
    // MARK: - Methods
    
    func signIn(signInModel: SignInModel) {
        print(signInModel.formattedPhoneNumber)
    }
    
}
