//
//  KeychainService.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 24.03.2024.
//

import Foundation
import KeychainSwift

enum KeychainKeys: String {
    case tokenKey
    case expiryKey
    case entryType
}

protocol KeychainServiceProtocol {
    func set(value: String, key: String)
    func get(key: String) -> String?
    func remove(key: String)
}

final class KeychainService: KeychainServiceProtocol {
    
    // MARK: - Properties
    
    static let shared = KeychainService(keychain: KeychainSwift())
    
    private let keychain: KeychainSwift
    
    // MARK: - Object Lifecycle
    
    private init(keychain: KeychainSwift) {
        self.keychain = keychain
    }
    
    // MARK: - Methods
    
    func set(value: String, key: String) {
        keychain.set(value, forKey: key)
    }
    
    func get(key: String) -> String? {
        return keychain.get(key)
    }
    
    func remove(key: String) {
        keychain.delete(key)
    }
}

extension KeychainService {
    func setAuthToken(token: String, expiry: Date) {
        set(value: token, key: KeychainKeys.tokenKey.rawValue)
        set(value: "\(expiry.timeIntervalSince1970)", key: KeychainKeys.expiryKey.rawValue)
    }
    
    func getAuthToken() -> String? {
        return get(key: KeychainKeys.tokenKey.rawValue)
    }
    
    func isTokenValid() -> Bool {
        guard let expiryString = keychain.get(KeychainKeys.expiryKey.rawValue),
                let expiryTimestamp = Double(expiryString) else {
            return false
        }
        
        let expiryDate = Date(timeIntervalSince1970: expiryTimestamp)
        return expiryDate > Date()
    }
    
    func removeToken() {
        remove(key: KeychainKeys.tokenKey.rawValue)
        remove(key: KeychainKeys.expiryKey.rawValue)
    }
}
