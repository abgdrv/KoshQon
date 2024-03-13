//
//  UITableView+Extensions.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 07.03.2024.
//

import UIKit

extension UITableView {

    func register<CellType: Reusable>(type: CellType.Type) {
        register(type, forCellReuseIdentifier: type.reuseID)
    }
    
    func dequeue<CellType: Reusable>(type: CellType.Type, for indexPath: IndexPath) -> CellType {
        return (dequeueReusableCell(withIdentifier: type.reuseID, for: indexPath) as? CellType)!
    }
}

extension UITableViewCell: Reusable {}
