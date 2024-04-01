//
//  EditProfileCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation
import UIKit
import Photos

final class EditProfileCoordinator: BaseCoordinator, EditProfileOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    var profile: Profile?
    
    private let router: RouterProtocol
    private let factory: EditProfileFlowFactory
        
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: EditProfileFlowFactory) {
        self.router = router
        self.factory = factory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showEditProfile()
    }
}

private extension EditProfileCoordinator {
    func showEditProfile() {
        guard let profile = profile else { return }
        let view = factory.makeEditProfileView(profile: profile)
        view.didProfileDetailCellTap = { [weak self] type in
            guard let self = self else { return }
            self.showProfileDetailCell(type: type)
        }
        view.didImagePickerOptionsShow = { [weak self] picker in
            guard let self = self else { return }
            self.showImagePickerOptions(picker: picker, view: view)
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
    
    func showPhoneDetail() {
        
    }
    
    func showCharacteristicsDetail() {
        
    }
    
    func showAboutDetail() {
        
    }
    
    func showProfileDetailCell(type: ProfileDetailType) {
        switch type {
        case .name:
            factory.showBanner(title: "Хотите изменить имя?",
                               message: "Для этого вы можете обратиться в техподдержку",
                               delay: 3)
        case .phone:
            showPhoneDetail()
        case .characteristics:
            showCharacteristicsDetail()
        case .about:
            showAboutDetail()
        default:
            break
        }
    }
}

private extension EditProfileCoordinator {
    func showImagePickerOptions(picker: UIImagePickerController, view: EditProfileViewController) {
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
            UIAlertAction(title: "Удалить фото", style: .destructive, handler: { [weak self] _ in
                guard let _ = self else { return }
                view.didImageDelete = {}
            }),
            UIAlertAction(title: "Закрыть", style: .cancel)
        ]
        let alertSheet = factory.makeAlertSheet(title: "Выберите фото",
                                                message: "Выберите фото из галереи или откройте камеру",
                                                with: actions)
        router.toPresent()?.present(alertSheet, animated: true)
    }
    
    func openImagePicker(picker: UIImagePickerController) {
        checkPermission() { [weak self] in
            guard let self = self else { return }
            router.toPresent()?.present(picker, animated: true)
        }
    }
    
    func checkPermission(onAccessHasBeenGranted: @escaping VoidCallback,
                         onAccessHasBeenDenied: VoidCallback? = nil) {
        let actions: [UIAlertAction] = [
            UIAlertAction(title: "Закрыть", style: .cancel, handler: nil),
            UIAlertAction(title: "Настройки", style: .default) { [weak self] action in
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
            self.router.present(alert, animated: true)
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

