//
//  DynamicTableView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import UIKit

final class DynamicTableView: UITableView {
    
    // MARK: - Properties
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
    
    // MARK: - Object Lifecycle
    
    init(style: UITableView.Style) {
        super.init(frame: .zero, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
}
