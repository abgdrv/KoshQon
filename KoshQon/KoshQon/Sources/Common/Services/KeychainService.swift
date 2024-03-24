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
}

protocol KeychainServiceProtocol {
    func setAuthToken(token: String, expiry: Date)
    func getAuthToken() -> String?
    func isTokenValid() -> Bool
    func removeToken() -> Bool
}

final class KeychainService {
    
    // MARK: - Properties
    
    static let shared = KeychainService(keychain: KeychainSwift())
    private let keychain: KeychainSwift
    
    // MARK: - Object Lifecycle
    
    private init(keychain: KeychainSwift) {
        self.keychain = keychain
    }
}

extension KeychainService: KeychainServiceProtocol {
    func setAuthToken(token: String, expiry: Date) {
        keychain.set(token, forKey: KeychainKeys.tokenKey.rawValue)
        keychain.set("\(expiry.timeIntervalSince1970)", forKey: KeychainKeys.expiryKey.rawValue)
    }
    
    func getAuthToken() -> String? {
        return keychain.get(KeychainKeys.tokenKey.rawValue)
    }
    
    func isTokenValid() -> Bool {
        guard let expiryString = keychain.get(KeychainKeys.expiryKey.rawValue),
                let expiryTimestamp = Double(expiryString) else {
            return false
        }
        
        let expiryDate = Date(timeIntervalSince1970: expiryTimestamp)
        return expiryDate > Date()
    }
    
    func removeToken() -> Bool {
        let tokenRemoved = keychain.delete(KeychainKeys.tokenKey.rawValue)
        let expiryRemoved = keychain.delete(KeychainKeys.expiryKey.rawValue)
        
        return tokenRemoved && expiryRemoved
    }
}
