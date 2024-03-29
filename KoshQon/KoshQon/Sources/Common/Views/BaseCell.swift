//
//  BaseCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import UIKit

class BaseCell: HighlightCell {
            
    // MARK: - Object Lifecycle
    
    init() {
        super.init(style: .default, reuseIdentifier: Self.reuseID)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented!")
    }
}
