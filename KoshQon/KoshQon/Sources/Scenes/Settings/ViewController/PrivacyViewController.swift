//
//  PrivacyViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.04.2024.
//

import UIKit
import SnapKit

final class PrivacyViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didDeactivateCellTap: Callback<VoidCallback>?
    
    private let viewModel: SettingsViewModel
    
    override var navigationTitleType: NavigationTitleType? {
        return .privacy
    }
    
    // MARK: - UI
    
    private lazy var privacyTableView = NavigationTableView(type: .privacy,
                                                            viewModels: viewModel.navigationCellViewModels)
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

private extension PrivacyViewController {
    func setupViews() {
        view.addSubview(privacyTableView)
    }
    
    func setupConstraints() {
        privacyTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupBindings() {
        privacyTableView.didNavigationCellTap = { [weak self] type in
            guard let self = self else { return }
            self.didDeactivateCellTap?({})
        }
    }
}
