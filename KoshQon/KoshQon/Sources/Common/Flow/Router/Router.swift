//
//  Router.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation
import UIKit

final class Router: NSObject {
    
    // MARK: - Properties
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController: VoidCallback]
    private var presentedViewController: UIViewController?
    
    // MARK: - Object Lifecycle
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
}

// MARK: - RouterProtocol

extension Router: RouterProtocol, UIViewControllerTransitioningDelegate {
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = .fullScreen
        if let presentedViewController = presentedViewController {
            presentedViewController.present(controller, animated: animated, completion: nil)
        } else {
            rootController?.present(controller, animated: animated, completion: nil)
        }
        self.presentedViewController = controller
    }
    
    func present(_ module: Presentable?, transitionStyle: UIModalTransitionStyle) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = transitionStyle
        if let presentedViewController = presentedViewController {
            presentedViewController.present(controller, animated: true, completion: nil)
        } else {
            rootController?.present(controller, animated: true, completion: nil)
        }
        self.presentedViewController = controller
    }
    
    func present(_ module: Presentable?,
                 presentationStyle: UIModalPresentationStyle,
                 transitionStyle: UIModalTransitionStyle) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = presentationStyle
        controller.modalTransitionStyle = transitionStyle
        if let presentedViewController = presentedViewController {
            presentedViewController.present(controller, animated: true, completion: nil)
        } else {
            rootController?.present(controller, animated: true, completion: nil)
        }
        self.presentedViewController = controller
    }
    
    func push(_ module: Presentable?) {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, hideBottomBar: Bool) {
        push(module, animated: true, hideBottomBar: hideBottomBar, hideNavBar: false, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, hideNavBar: Bool) {
        push(module, animated: animated, hideBottomBar: false, hideNavBar: hideNavBar, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: VoidCallback?) {
        push(module, animated: animated, hideBottomBar: false, hideNavBar: false, completion: completion)
    }
    
    func push(_ module: Presentable?,
              animated: Bool,
              hideBottomBar: Bool,
              hideNavBar: Bool,
              completion: VoidCallback?) {
        guard let controller = module?.toPresent(), (controller is UINavigationController == false) else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        
        if let completion = completion {
            completions[controller] = completion
        }
        controller.hidesBottomBarWhenPushed = hideBottomBar
        self.rootController?.isNavigationBarHidden = hideNavBar
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule() {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func dismiss(_ module: Presentable?) {
        guard let controller = module?.toPresent() else { return }
        self.presentedViewController = controller.presentingViewController
        controller.dismiss(animated: true)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: VoidCallback?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideNavBar: false)
    }
    
    func setRootModule(_ module: Presentable?, hideNavBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        
        self.rootController?.setViewControllers([controller], animated: false)
        self.rootController?.isNavigationBarHidden = hideNavBar
        
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        if let window = UIApplication.shared.keyWindow {
            UIView.transition(with: window, duration: duration, options: options, animations: {})
        }
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach {
                runCompletion(for: $0)
            }
        }
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
}

// MARK: - Private methods

private extension Router {
    func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
