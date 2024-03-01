//
//  PHPhotoLibrary+Extensions.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import Photos
import UIKit

extension PHPhotoLibrary {
    static func checkPermission(controller: UIViewController,
                        onAccessHasBeenGranted: @escaping VoidCallback,
                        onAccessHasBeenDenied: VoidCallback? = nil) {
        let onDeniedOrRestricted = onAccessHasBeenDenied ?? {
            let alert = UIAlertController(title: "Unable to load your album groups",
                                          message: "You can enable access in Privacy Settings",
                                          preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
            let settingsAction = UIAlertAction(title: "Настройки", style: .default) { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
            
            alert.addAction(cancelAction)
            alert.addAction(settingsAction)
            
            DispatchQueue.main.async {
                controller.present(alert, animated: true)
            }
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
        @unknown default:
            break
        }
    }
}

private func onNotDetermined(_ onDeniedOrRestricted: @escaping VoidCallback,
                             _ onAuthorized: @escaping VoidCallback) {
    PHPhotoLibrary.requestAuthorization { status in
        switch status {
        case .notDetermined:
            onNotDetermined(onDeniedOrRestricted, onAuthorized)
        case .denied, .restricted:
            onDeniedOrRestricted()
        case .authorized:
            onAuthorized()
        case .limited:
            onDeniedOrRestricted()
        @unknown default:
            break
        }
    }
}
