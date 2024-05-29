//
//  String+Extensions.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

extension String {
    
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
}

extension String {
    var localized: String {
        let lang = UserDefaultsService.shared.language
        if let bundlePath = Bundle.main.path(forResource: lang.rawValue, ofType: "lproj"), let bundle = Bundle(path: bundlePath) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
        } else {
            if let bundlePath = Bundle.main.path(forResource: LanguageType.en.rawValue, ofType: "lproj"), let bundle = Bundle(path:bundlePath) {
                return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
            }
            return NSLocalizedString(self, comment: "")
        }
    }
}
