//
//  AuthOutputCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation

protocol AuthOutputCoordinator {
    var finishFlow: VoidCallback? { get set }
}
