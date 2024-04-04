//
//  NavigationTableView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.04.2024.
//

import UIKit
import SnapKit

final class NavigationTableView: BaseView {

    // MARK: - Properties
    
    var didNavigationCellTap: Callback<NavigationCellType>?
    
    private let type: NavigationTableViewType
    private let navigationCellViewModels: [NavigationCellViewModel]
    
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
        super.init()
        setupViews()
        setupConstraints()
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
            self.didNavigationCellTap?(type)
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
}

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
