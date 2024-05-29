//
//  SettingsOutputCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.03.2024.
//

import Foundation

protocol SettingsOutputCoordinator {
    var finishFlow: Callback<Bool>? { get set }
}
