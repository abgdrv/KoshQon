//
//  UserDefaultsService.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    func set(value: Any?, for key: String)
    func value(for key: String) -> Any?
    func removeObject(for key: String)
}

extension UserDefaults: UserDefaultsServiceProtocol {
    func set(value: Any?, for key: String) {
        self.setValue(value, forKey: key)
    }
    
    func value(for key: String) -> Any? {
        return self.value(forKey: key)
    }
    
    func removeObject(for key: String) {
        return self.removeObject(forKey: key)
    }
}

enum UserDefaultsKey: String {
    case phoneCodes
    case selectedPhoneCode
    case entryType
    case pinBiometricToken
    case client
    case pinCode
    case services
    case theme
    case language
    
    var key: String {
        return self.rawValue
    }
}

final class UserDefaultsService {
    
    // MARK: - Properties
    
    static let shared = UserDefaultsService()
    private let defaults = UserDefaults.standard
    
    // MARK: - Object Lifecycle
    
    private init() {}
}

// MARK: - UserDefaultsServiceProtocol

extension UserDefaultsService: UserDefaultsServiceProtocol {
    func set(value: Any?, for key: String) {
        defaults.setValue(value, forKey: key)
    }
    
    func value(for key: String) -> Any? {
        return defaults.value(forKey: key)
    }
    
    func removeObject(for key: String) {
        return defaults.removeObject(forKey: key)
    }
}
