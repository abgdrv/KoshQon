//
//  SplashScreenFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation

protocol SplashScreenFlowFactory: AlertFlowFactory {
    func makeSplashScreen() -> SplashScreenViewController
}
