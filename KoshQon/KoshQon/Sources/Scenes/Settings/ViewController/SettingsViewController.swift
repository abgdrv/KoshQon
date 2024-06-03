//
//  SettingsViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import UIKit
import SnapKit

final class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didNavigationCellTap: Callback<NavigationCellType>?
    
    private let viewModel: SettingsViewModel
    
    override var navigationTitleType: NavigationTitleType? {
        return .settings
    }
    
    // MARK: - UI
    
    private lazy var settingsTableView = NavigationTableView(type: .settings, viewModels: viewModel.navigationCellViewModels)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBindings()
    }
}

// MARK: - Setup Views

private extension SettingsViewController {
    func setupViews() {
        view.addSubview(settingsTableView)
    }
    
    func setupConstraints() {
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupBindings() {
        settingsTableView.didNavigationCellTap = { [weak self] type in
            guard let self = self else { return }
            self.didNavigationCellTap?(type)
        }
    }
}
