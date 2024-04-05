//
//  ImageDetailViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.04.2024.
//

import UIKit
import SnapKit

final class ImageDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didCancel: VoidCallback?
    
    private let image: UIImage?
    
    // MARK: - UI
    
    private lazy var anchorView = SeparatorView()
    
    private lazy var profileImageView = ProfileImageView(image: image,
                                                         isEditable: false)
    
    // MARK: - Object Lifecycle
    
    init(image: UIImage?) {
        self.image = image
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup Views

private extension ImageDetailViewController {
    private func setupViews() {
        view.addSubviews(anchorView, profileImageView)
    }
    
    private func setupConstraints() {
        anchorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(view.bounds.width - 50)
        }
    }
}

// MARK: - Actions

private extension ImageDetailViewController {
    @objc private func cancelButtonTapped() {
        didCancel?()
    }
}
