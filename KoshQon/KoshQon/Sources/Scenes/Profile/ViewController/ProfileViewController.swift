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
    var didEditProfileTap: VoidCallback?
    var didFriendsTap: VoidCallback?
    
    private let viewModel: ProfileViewModel
    
    override var navigationTitleType: NavigationTitleType? {
        return viewModel.profileType == .myProfile ? .profile : nil
    }
    
    // MARK: - UI
    
    private lazy var profileView = ProfileView(viewModel: viewModel)
    
    private lazy var editButton = UIBarButtonItem(
        image: AppImage.Profile.edit.uiImage?.withRenderingMode(.alwaysOriginal),
        style: .plain,
        target: self,
        action: #selector(editButtonTapped)
    ).apply {
        $0.imageInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
    }
    
    private lazy var settingsButton = UIBarButtonItem(
        image: AppImage.Profile.settings.uiImage?.withRenderingMode(.alwaysOriginal),
        style: .plain,
        target: self,
        action: #selector(settingsButtonTapped)
    )
    
    private lazy var shareButton = UIBarButtonItem(
        image: AppImage.Common.share.uiImage?.withRenderingMode(.alwaysOriginal),
        style: .plain,
        target: self,
        action: #selector(shareButtonTapped)
    )
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.profileType == .myProfile {
            tabBarController?.tabBar.isHidden = false
        }
        
        viewModel.getAnnouncements()
        profileView = ProfileView(viewModel: viewModel)
        profileView.commonView.update()
        view = profileView
        setupBindings()
        setupNavigation()
    }
}

// MARK: - Setup

private extension ProfileViewController {
    func setupNavigation() {
        navigationItem.rightBarButtonItems = viewModel.profileType == .myProfile ? [settingsButton, editButton] : [shareButton]
    }
    
    func setupBindings() {
        profileView.didFriendsTap = { [weak self] in
            guard let self = self else { return }
            self.didFriendsTap?()
        }
    }
}

// MARK: - Actions

private extension ProfileViewController {
    @objc func editButtonTapped() {
        didEditProfileTap?()
    }
    
    @objc func settingsButtonTapped() {
        didSettingsTap?()
    }
    
    @objc func shareButtonTapped() {
        
    }
}
