//
//  SettingsViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import UIKit

final class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didNavigationCellSelect: Callback<NavigationCellType>?
    
    private let viewModel: SettingsViewModel
    
    override var navigationType: NavigationTitleType? {
        return .settings
    }
    
    // MARK: - UI
    
    private lazy var settingsView = SettingsView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
}

// MARK: - Setup

private extension SettingsViewController {
    func setupBindings() {
        settingsView.didNavigationCellSelect = { [weak self] type in
            guard let self = self else { return }
            self.didNavigationCellSelect?(type)
        }
    }
}
