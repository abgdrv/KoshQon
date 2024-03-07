//
//  UICollectionView+Extensions.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 07.03.2024.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let cellId = String(describing: cellClass.self)
        register(cellClass.self, forCellWithReuseIdentifier: cellId)
    }
    
    func dequeueCell<T>(_ cellClass: T.Type, indexPath path: IndexPath) -> T {
        let cellId = String(describing: T.self)
        return self.dequeueReusableCell(withReuseIdentifier: cellId, for: path) as! T
    }
}
