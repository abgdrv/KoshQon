//
//  RegisterFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.03.2024.
//

import Foundation

protocol RegisterFlowFactory: ForgotPasswordFlowFactory {
    func makePersonalView() -> PersonalViewController
}

