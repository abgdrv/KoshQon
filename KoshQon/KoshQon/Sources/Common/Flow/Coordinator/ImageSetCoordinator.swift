//
//  ImageSetCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 07.04.2024.
//

import UIKit
import Photos

class ImageSetCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private let router: RouterProtocol
    private let factory: ImageSetFlowFactory
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: ImageSetFlowFactory) {
        self.router = router
        self.factory = factory
        super.init(alertFlowFactory: factory)
    }
    
    // MARK: - Methods
    
    func showImageZoom(image: UIImage?) {
        let view = factory.makeImageZoomView(image: image)
        view.didCancel = { [weak self] in
            guard let self = self else { return }
            self.router.dismissModule()
        }
        router.toPresent()?.present(view, animated: true)
    }
    
    func showImagePickerOptions(picker: UIImagePickerController, view: ImageSettable, isImageSelected: Bool) {
        var actions: [UIAlertAction] = [
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
                    var view = view
                    view.didImageDelete = {}
                },
                at: 3
            )
        }
        
        guard let alertSheet = alertFlowFactory?.makeAlertSheet(
            title: "Выберите фото",
            message: "Выберите фото из галереи или откройте камеру",
            with: actions
        ) else { return }
        
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
            UIAlertAction(title: "Закрыть", style: .cancel),
            UIAlertAction(title: "Настройки", style: .default) { [weak self] action in
                guard let _ = self else { return }
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
        ]
        
        let onDeniedOrRestricted = onAccessHasBeenDenied ?? { [weak self] in
            guard let self = self else { return }
            
            guard let alert = self.alertFlowFactory?.makeAlert(
                title: "Unable to load your album groups",
                message: "You can enable access in Privacy Settings",
                with: actions
            ) else { return }
            
            router.toPresent()?.present(alert, animated: true)
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
