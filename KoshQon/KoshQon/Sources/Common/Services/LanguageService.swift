//
//  LanguageService.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.05.2024.
//

import Foundation

protocol LanguageServiceProtocol {
    func setLanguage(_ newLang: LanguageType)
}

final class LanguageService: LanguageServiceProtocol {
    
    static let shared = LanguageService()
    
    private init() {}
    
    func setLanguage(_ newLang: LanguageType) {
        UserDefaultsService.shared.language = newLang
    }
}
