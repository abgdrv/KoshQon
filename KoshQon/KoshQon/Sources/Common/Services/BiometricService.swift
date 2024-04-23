//
//  BiometricService.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.04.2024.
//

import Foundation
import LocalAuthentication

protocol BiometricServiceProtocol {
    func getEntryType() -> EntryType
    func getAvailableEntryType() -> EntryType
    func saveBioEntryType()
    func removeBioEntryType()
}

final class BiometricService: BiometricServiceProtocol {
    
    // MARK: - Properties
    
    private let keychainService = KeychainService.shared
    
    // MARK: - Methods
    
    func getEntryType() -> EntryType {
        if let entryType = keychainService.get(key: KeychainKeys.entryType.rawValue),
           let type = EntryType(rawValue: entryType) {
            return type
        }
        return .none
    }
    
    func getAvailableEntryType() -> EntryType {
        var error: NSError?
        let context = LAContext()
        
        guard context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) else { return .none }
        
        if #available(iOS 11.0, *) {
            switch context.biometryType {
            case .faceID:
                return .faceId
            case .touchID:
                return .touchId
            default:
                return .none
            }
        }
        return .none
    }
    
    func saveBioEntryType() {
        keychainService.set(value: getAvailableEntryType().rawValue, key: KeychainKeys.entryType.rawValue)
    }
    
    func removeBioEntryType() {
        if let _ = keychainService.get(key: KeychainKeys.entryType.rawValue) {
            keychainService.remove(key: KeychainKeys.entryType.rawValue)
        }
    }
}
