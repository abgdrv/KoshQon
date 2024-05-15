//
//  PassCodeFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 13.05.2024.
//

import Foundation

protocol PassCodeFlowFactory: AlertFlowFactory {
    func makePasscodeView(type: PassCodeType) -> PassCodeViewController
}
