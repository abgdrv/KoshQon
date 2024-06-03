//
//  LanguageViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 29.05.2024.
//

import UIKit

final class LanguageViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didLanguageChange: VoidCallback?
    
    override var navigationTitleType: NavigationTitleType? {
        return .language
    }
        
    private let viewModel: SettingsViewModel
    
    private lazy var languageTableView = NavigationTableView(type: .language, viewModels: viewModel.navigationCellViewModels)
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBindings()
    }
}

private extension LanguageViewController {
    func setupViews() {
        view.addSubview(languageTableView)
    }
    
    func setupConstraints() {
        languageTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupBindings() {
        languageTableView.didNavigationCellTap = { [weak self] type in
            guard let self = self else { return }
            viewWillAppear(true)
            self.didLanguageChange?()
        }
    }
}
