//
//  TabBarOutputCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 25.03.2024.
//

import Foundation

protocol TabBarOutputCoordinator {
    var didSessionExpired: VoidCallback? { get set }
    var finishFlow: VoidCallback? { get set }
}
