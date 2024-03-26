//
//  MainScreenOutputCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 25.03.2024.
//

import Foundation

protocol MainScreenOutputCoordinator {
    var finishFlow: VoidCallback? { get set }
    var reloadFlow: VoidCallback? { get set }
}
