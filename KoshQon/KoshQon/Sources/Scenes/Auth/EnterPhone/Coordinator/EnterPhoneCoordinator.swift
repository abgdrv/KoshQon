//
//  EnterPhoneCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.03.2024.
//

import Foundation

final class EnterPhoneCoordinator: ImageSetCoordinator, EnterPhoneOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let type: EnterPhoneType
    
    private let router: RouterProtocol
    private let factory: EnterPhoneFlowFactory
    
    // MARK: - Object Lifecycle
    
    init(type: EnterPhoneType, router: RouterProtocol, factory: EnterPhoneFlowFactory) {
        self.type = type
        self.router = router
        self.factory = factory
        super.init(router: router, factory: factory)
    }
    
    override func start() {
        showEnterPhone()
    }
}

private extension EnterPhoneCoordinator {
    func showEnterPhone() {
        let view = factory.makeEnterPhoneView(type: type)
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.showSms()
        }
        router.push(view)
    }
    
    func showSms() {
        let view = factory.makeSmsCodeView()
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            switch self.type {
            case .registration:
                self.showPersonal()
            case .forgotPassword:
                self.showSetPassword()
            case .changePhone:
                self.finishFlow?()
            }
        }
        router.push(view)
    }
    
    func showPersonal() {
        let view = factory.makePersonalView()
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.showSetPassword()
        }
        view.didImagePickerOptionsShow = { [weak self] picker, isImageSelected in
            guard let self = self else { return }
            self.showImagePickerOptions(picker: picker, view: view, isImageSelected: isImageSelected)
        }
        view.didCropCancel = { [weak self] in
            guard let self = self else { return }
            self.router.popModule()
        }
        view.didImageCrop = { [weak self] in
            guard let self = self else { return }
            self.router.popModule()
        }
        view.didCropImageShow = { [weak self] cropImage in
            guard let self = self else { return }
            self.router.push(cropImage)
        }
        router.push(view)
    }
    
    func showSetPassword() {
        let view = factory.makeSetPasswordView(type: type == .registration ? .create : .change)
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.finishFlow?()
        }
        router.push(view)
    }
}
