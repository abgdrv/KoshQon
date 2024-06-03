//
//  ThemeViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.04.2024.
//

import UIKit
import SnapKit

final class ThemeViewController: BaseViewController {
    
    // MARK: - Properties
        
    private let viewModel: SettingsViewModel
    
    override var navigationTitleType: NavigationTitleType? {
        return .theme
    }
    
    // MARK: - UI
    
    private lazy var themeTableView = NavigationTableView(type: .theme, viewModels: viewModel.navigationCellViewModels)
    
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
    }
}

private extension ThemeViewController {
    func setupViews() {
        view.addSubview(themeTableView)
    }
    
    func setupConstraints() {
        themeTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
