//
//  LoginViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 21.02.2024.
//

import Foundation

protocol LoginProtocol {
    func login(loginModel: LoginModel)
}

final class LoginViewModel: LoginProtocol {
    
    // MARK: - Properties
    
    private var model: LoginModel?
    
    // MARK: - Methods
    
    func login(loginModel: LoginModel) {
        print(loginModel.fullNumber)
    }
    
}
