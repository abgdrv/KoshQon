//
//  NavigationTableView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.04.2024.
//

import UIKit
import SnapKit

final class NavigationTableView: UIView {
    
    // MARK: - Properties
    
    var didNavigationCellTap: Callback<NavigationCellType>?
    
    private let type: NavigationTableViewType
    private let navigationCellViewModels: [NavigationCellViewModel]
    
    private var selectedIndexPath: IndexPath? {
        didSet {
            navigationTableView.reloadData()
        }
    }
        
    // MARK: - UI
    
    private lazy var navigationTableView = UITableView(frame: .zero, style: .grouped).apply {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.register(type: NavigationCell.self)
    }
    
    // MARK: - Object Lifecycle
    
    init(type: NavigationTableViewType, viewModels: [NavigationCellViewModel]) {
        self.type = type
        self.navigationCellViewModels = viewModels
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        if type == .theme {
            selectedIndexPath = getSelectedCell()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NavigationTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return type == .settings ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == .settings {
            return section == 0 ? 4 : 2
        }
        return navigationCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var index = indexPath.row
        if type == .settings {
            index += indexPath.section == 0 ? 0 : 4
        }
        let cell = NavigationCell(viewModel: navigationCellViewModels[index])
        cell.didNavigationCellTap = { [weak self] type in
            guard let self = self else { return }
            if type == .themeLight || type == .themeDark || type == .themeDefault {
                AppThemeService.shared.updateThemeState(with: type.theme)
                selectCell(indexPath: indexPath)
            }
            self.didNavigationCellTap?(type)
        }
        if type == .theme  {
            cell.accessoryType = selectedIndexPath == indexPath ? .checkmark : .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if type == .settings {
            return section == 0 ? nil : UIView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if type == .settings {
            return section == 0 ? 0 : 50
        }
        return 0
    }
    
    func selectCell(indexPath: IndexPath) {
        selectedIndexPath = indexPath
        UserDefaultsService.shared.set(value: indexPath.section, for: UserDefaultsKey.themeSection.key)
        UserDefaultsService.shared.set(value: indexPath.row, for: UserDefaultsKey.themeRow.key)
    }

    func getSelectedCell() -> IndexPath? {
        if let section = UserDefaultsService.shared.value(for: UserDefaultsKey.themeSection.key) as? Int,
           let row = UserDefaultsService.shared.value(for: UserDefaultsKey.themeRow.key) as? Int {
            return IndexPath(row: row, section: section)
        }
        return IndexPath(row: 2, section: 0)
    }
}

// MARK: - Setup Views

private extension NavigationTableView {
    func setupViews() {
        addSubview(navigationTableView)
    }
    
    func setupConstraints() {
        navigationTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
