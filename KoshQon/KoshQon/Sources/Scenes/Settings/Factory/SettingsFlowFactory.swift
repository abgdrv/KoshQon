//
//  SettingsFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.03.2024.
//

import Foundation

protocol SettingsFlowFactory: AlertFlowFactory {
    func makeSettingsView() -> SettingsViewController
    func makePrivacyView() -> PrivacyViewController
}
