//
//  SettingsView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import UIKit
import SnapKit

final class SettingsView: BaseView {
    
    // MARK: - Properties
    
    var didNavigationCellSelect: Callback<NavigationCellType>?
    
    private let viewModel: SettingsViewModel
    
    // MARK: - UI
    
    private lazy var navigationTableView = UITableView(frame: .zero, style: .grouped).apply {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = AppColor.Theme.mainBackground.uiColor
        $0.register(type: NavigationCell.self)
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init()
        setupViews()
        setupConstraints()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 4 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var index = indexPath.row
        index += indexPath.section == 0 ? 0 : 4
        let cell = NavigationCell(viewModel: viewModel.navigationCellViewModels[index])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? nil : UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = indexPath.row
        index += indexPath.section == 0 ? 0 : 4
        didNavigationCellSelect?(viewModel.navigationCellViewModels[index].type)
    }
}

// MARK: - Setup Views

private extension SettingsView {
    func setupViews() {
        addSubview(navigationTableView)
    }
    
    func setupConstraints() {
        navigationTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
