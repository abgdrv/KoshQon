//
//  ProfileViewViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import UIKit

final class ProfileViewViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: ProfileViewModel
    
    // MARK: - UI
    
    private lazy var profileView = ProfileView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Navigation

private extension ProfileViewViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: .profile)
        let editImage = AppImage.Profile.edit.uiImage?.withRenderingMode(.alwaysOriginal)
        let editButton = UIBarButtonItem(image: editImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(editButtonTapped))
        let settingsImage = AppImage.Profile.settings.uiImage?.withRenderingMode(.alwaysOriginal)
        let settingsButton = UIBarButtonItem(image: settingsImage,
                                             style: .plain,
                                             target: self,
                                             action: #selector(settingsButtonTapped))
        editButton.imageInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        navigationItem.rightBarButtonItems = [settingsButton, editButton]
    }
}

// MARK: - Actions

private extension ProfileViewViewController {
    @objc func editButtonTapped() {
        
    }
    
    @objc func settingsButtonTapped() {
        
    }
}
