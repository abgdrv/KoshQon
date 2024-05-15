//
//  PassCodeViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.04.2024.
//

import Foundation

final class PassCodeViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let type: PassCodeType
//    private let biometricService: BiometricService
    
    var title: String {
        return type == .enter ? "Введите код доступа" : "Подтвердите код доступа"
    }
    
    private var isPasscode: Bool {
        if let _ = UserDefaultsService.shared.value(for: KeychainKeys.passcode.rawValue) as? String {
            return true
        }
        return false
    }
    
    // MARK: - Object Lifecycle
    
    init(type: PassCodeType) {
        self.type = type
//        self.biometricService = BiometricService()
    }
    
    func submitPasscode(code: String, completion: @escaping Callback<Bool>) {
//        biometricService.saveBioEntryType()
        if isPasscode {
            if type == .enter {
                UserDefaultsService.shared.set(value: code, for: KeychainKeys.passcode.rawValue)
            }
            if checkPasscode(code: code) {
                completion(type == .verify)
            }
        } else {
            if type == .enter {
                UserDefaultsService.shared.set(value: code, for: KeychainKeys.passcode.rawValue)
            }
            completion(true)
        }
    }
    
    func checkPasscode(code: String) -> Bool {
        guard let passcode = UserDefaultsService.shared.value(for: KeychainKeys.passcode.rawValue) as? String else {
            return false
        }
        return passcode == code
    }
}
