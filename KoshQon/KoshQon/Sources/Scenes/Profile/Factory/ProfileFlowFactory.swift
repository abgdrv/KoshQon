//
//  ProfileFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation

protocol ProfileFlowFactory: AlertFlowFactory {
    func makeProfileView(type: ProfileType) -> ProfileViewController
}
