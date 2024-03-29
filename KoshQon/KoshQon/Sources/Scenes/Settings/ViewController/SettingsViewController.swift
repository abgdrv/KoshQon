//
//  SettingsViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import UIKit

final class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didNavigationCellTap: Callback<NavigationCellType>?
    
    private let viewModel: SettingsViewModel
    
    override var navigationTitleType: NavigationTitleType? {
        return .settings
    }
    
    // MARK: - UI
    
    private lazy var settingsView = SettingsView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = settingsView
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

private extension SettingsViewController {
    func setupBindings() {
        settingsView.didNavigationCellTap = { [weak self] type in
            guard let self = self else { return }
            self.didNavigationCellTap?(type)
        }
    }
}
