//
//  MainScreenView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit
import SnapKit

final class MainScreenView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: - Setup Views

private extension MainScreenView {
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
}
