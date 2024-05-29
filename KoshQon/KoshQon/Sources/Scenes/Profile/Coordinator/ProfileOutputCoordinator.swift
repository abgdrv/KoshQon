//
//  ProfileOutputCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation

protocol ProfileOutputCoordinator {
    var finishFlow: Callback<Bool>? { get set }
}
