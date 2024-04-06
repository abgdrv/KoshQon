//
//  EnterPhoneFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.03.2024.
//

import Foundation
import UIKit

protocol EnterPhoneFlowFactory: ImageSetFlowFactory {
    func makePersonalView() -> PersonalViewController
    func makeEnterPhoneView(type: EnterPhoneType) -> EnterPhoneViewController
    func makeSmsCodeView() -> SmsCodeViewController
    func makeSetPasswordView(type: SetPasswordType) -> SetPasswordViewController
    func makeImageZoomView(image: UIImage?) -> ImageDetailViewController
}

