//
//  AuthFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation

protocol AuthFlowFactory {
    func makeLoginView() -> LoginViewController
    func makeRegisterView() -> EnterPhoneViewController
}
