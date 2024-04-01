//
//  EnterPhoneFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.03.2024.
//

import Foundation

protocol EnterPhoneFlowFactory: AlertFlowFactory {
    func makePersonalView() -> PersonalViewController
    func makeEnterPhoneView(type: EnterPhoneType) -> EnterPhoneViewController
    func makeSmsCodeView() -> SmsCodeViewController
    func makeSetPasswordView(type: SetPasswordType) -> SetPasswordViewController
}

