//
//  EditProfileFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

protocol EditProfileFlowFactory: AlertFlowFactory {
    func makeEditProfileView(profile: Profile) -> EditProfileViewController
    func makeEnterPhoneView(type: EnterPhoneType) -> EnterPhoneViewController
    func makeAboutMeView(existingText: String?) -> ProfileAboutMeViewController
}
