//
//  PassCodeViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.04.2024.
//

import Foundation

final class PassCodeViewModel {
    
    // MARK: - Properties
    
    private let type: PassCodeType
    private let biometricService: BiometricService
    
    // MARK: - Object Lifecycle
    
    init(type: PassCodeType) {
        self.type = type
        self.biometricService = BiometricService()
    }
    
    func savePassCode(code: String) {
        biometricService.saveBioEntryType()
        // TODO
    }
}
