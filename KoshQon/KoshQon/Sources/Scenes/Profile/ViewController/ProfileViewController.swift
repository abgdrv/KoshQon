//
//  ProfileViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didSettingsTap: VoidCallback?
    
    private let viewModel: ProfileViewModel
    
    override var navigationType: NavigationTitleType? {
        return .profile
    }
    
    // MARK: - UI
    
    private lazy var profileView = ProfileView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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

private extension ProfileViewController {
    func setupNavigation() {
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

private extension ProfileViewController {
    @objc func editButtonTapped() {
        
    }
    
    @objc func settingsButtonTapped() {
        didSettingsTap?()
    }
}
