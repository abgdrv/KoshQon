//
//  Parameters.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.05.2024.
//

import Foundation

protocol Parameters: Encodable {
    func toData() -> Data?
    
}

extension Parameters where Self: Encodable {
    func toData() -> Data? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return data
    }
    
    func toDict() -> [String:Any] {
        guard let data = toData() else {
            return [:]
        }
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: []) else {
            return [:]
        }
        return dict as? [String : Any] ?? [:]
    }
    
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value:Any {
    
    func toData() -> Data? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
            return nil
        }
        return data
    }
}


extension Data {
    func toString() -> String {
        return String(data: self, encoding: .utf8)!
    }
}
