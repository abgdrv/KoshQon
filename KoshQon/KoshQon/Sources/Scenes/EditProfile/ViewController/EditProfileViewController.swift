//
//  EditProfileViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import UIKit

final class EditProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: EditProfileViewModel
    
    override var navigationTitleType: NavigationTitleType? {
        return .personalInfo
    }
    
    // MARK: - UI
    
    private lazy var editProfileView = EditProfileView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = editProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Setup

private extension EditProfileViewController {
    func setupBindings() {
        
    }
}
