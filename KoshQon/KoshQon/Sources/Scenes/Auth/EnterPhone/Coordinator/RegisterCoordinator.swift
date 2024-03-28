//
//  RegisterCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.03.2024.
//

import Foundation
import UIKit
import Photos

final class RegisterCoordinator: BaseCoordinator, RegisterOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: RegisterFlowFactory
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: RegisterFlowFactory) {
        self.router = router
        self.factory = factory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showRegister()
    }
}

private extension RegisterCoordinator {
    func showRegister() {
        let view = factory.makeEnterPhoneView(type: .register)
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
            self.showPersonal()
        }
        router.push(view)
    }
    
    func showPersonal() {
        let view = factory.makePersonalView()
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.showCreatePassword()
        }
        view.didShowImagePickerOptions = { [weak self] picker in
            guard let self = self else { return }
            self.showImagePickerOptions(picker: picker)
        }
        view.didCancelCrop = { [weak self] in
            guard let self = self else { return }
            self.router.popModule()
        }
        view.didCropImage = { [weak self] in
            guard let self = self else { return }
            self.router.popModule()
        }
        view.didShowCropImage = { [weak self] cropImage in
            guard let self = self else { return }
            self.router.push(cropImage)
        }
        router.push(view)
    }
    
    func showCreatePassword() {
        let view = factory.makeSetPasswordView(type: .create)
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.router.popToRootModule(animated: true)
        }
        router.push(view)
    }
}

private extension RegisterCoordinator {
    func showImagePickerOptions(picker: UIImagePickerController) {
        let actions: [UIAlertAction] = [
            UIAlertAction(title: "Камера", style: .default) { [weak self] _ in
                guard let self = self else { return }
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    picker.sourceType = .camera
                    self.openImagePicker(picker: picker)
                }
            },
            UIAlertAction(title: "Галерея", style: .default) { [weak self] _ in
                guard let self = self else { return }
                picker.sourceType = .photoLibrary
                self.openImagePicker(picker: picker)
            },
            UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        ]
        let alertSheet = factory.makeAlertSheet(title: "Выберите фото",
                                                message: "Выберите фото из галереи или откройте камеру",
                                                with: actions)
        router.toPresent()?.present(alertSheet, animated: true)
    }
    
    func openImagePicker(picker: UIImagePickerController) {
        checkPermission() { [weak self] in
            guard let self = self else { return }
            self.router.toPresent()?.present(picker, animated: true)
        }
    }
    
    func checkPermission(onAccessHasBeenGranted: @escaping VoidCallback,
                         onAccessHasBeenDenied: VoidCallback? = nil) {
        let actions: [UIAlertAction] = [
            UIAlertAction(title: "Закрыть", style: .cancel, handler: nil),
            UIAlertAction(title: "Настройки", style: .default) { [weak self] _ in
                guard let _ = self else { return }
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
        ]
        let onDeniedOrRestricted = onAccessHasBeenDenied ?? { [weak self] in
            guard let self = self else { return }
            let alert = self.factory.makeAlert(title: "Unable to load your album groups",
                                               message: "You can enable access in Privacy Settings",
                                               with: actions)
            self.router.toPresent()?.present(alert, animated: true)
        }
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            onNotDetermined(onDeniedOrRestricted, onAccessHasBeenGranted)
        case .denied, .restricted:
            onDeniedOrRestricted()
        case .authorized:
            onAccessHasBeenGranted()
        case .limited:
            onDeniedOrRestricted()
        default:
            break
        }
    }
    
    func onNotDetermined(_ onDeniedOrRestricted: @escaping VoidCallback,
                         _ onAuthorized: @escaping VoidCallback) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .notDetermined:
                self.onNotDetermined(onDeniedOrRestricted, onAuthorized)
            case .denied, .restricted:
                onDeniedOrRestricted()
            case .authorized:
                onAuthorized()
            case .limited:
                onDeniedOrRestricted()
            default:
                break
            }
        }
    }
}
