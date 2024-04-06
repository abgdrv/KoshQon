//
//  UIViewController+Extensions.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation
import UIKit

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}

extension UIViewController {
    func presentInKeyWindow(animated: Bool = true, completion: VoidCallback? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?
                .present(self, animated: animated, completion: completion)
        }
    }
    
    func presentInKeyWindowPresentedController(animated: Bool = true, completion: VoidCallback? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindowPresentedController?
                .present(self, animated: animated, completion: completion)
        }
    }
}
