//
//  EnterPhoneCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.03.2024.
//

import Foundation
import UIKit
import Photos

final class EnterPhoneCoordinator: BaseCoordinator, EnterPhoneOutputCoordinator {
    
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
        super.init(alertFlowFactory: factory)
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
    
    func showImageZoom(image: UIImage?) {
        let view = factory.makeImageZoomView(image: image)
        view.didCancel = { [weak self] in
            guard let self = self else { return }
            self.router.dismissModule()
        }
        router.toPresent()?.present(view, animated: true)
    }
}

private extension EnterPhoneCoordinator {
    func showImagePickerOptions(picker: UIImagePickerController,
                                view: PersonalViewController,
                                isImageSelected: Bool) {
        var actions: [UIAlertAction] = [
            UIAlertAction(title: "Камера", style: .default) { action in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    picker.sourceType = .camera
                    self.openImagePicker(picker: picker)
                }
            },
            UIAlertAction(title: "Галерея", style: .default) { action in
                picker.sourceType = .photoLibrary
                self.openImagePicker(picker: picker)
            },
            UIAlertAction(title: "Закрыть", style: .cancel)
        ]
        
        if isImageSelected {
            actions.insert(
                UIAlertAction(title: "Посмотреть", style: .default) { action in
                    self.showImageZoom(image: view.image)
                },
                at: 2
            )
            actions.insert(
                UIAlertAction(title: "Удалить фото", style: .destructive) { action in
                    view.didImageDelete = {}
                }, 
                at: 3
            )
        }
        
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
