//
//  ActionButton.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 11.04.2024.
//

import UIKit

enum ActionButtonType {
    case write
    case call
    case friend
}

final class ActionButton: UIButton {

    // MARK: - Properties
    
    var type: ActionButtonType? {
        didSet {
            setup()
        }
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        switch type {
        case .write:
            setup(backgroundColor: AppColor.Static.darkBlue.uiColor, title: "Написать")
        case .call:
            setup(backgroundColor: AppColor.Static.green.uiColor, title: "Позвонить")
        case .friend:
            setup(backgroundColor: AppColor.Static.orange.uiColor)
        default:
            break
        }
    }
    
    private func setup(
        backgroundColor: UIColor,
        title: String? = nil,
        font: UIFont = AppFont.medium.s14
    ) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        set(font: font, titleColor: AppColor.Static.white.uiColor)
    }
}
