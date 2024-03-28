//
//  MainScreenView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit
import SnapKit

final class MainScreenView: BaseView {
    
    // MARK: - Properties
    
    private let viewModel: MainScreenViewModel
    
    // MARK: - UI
    
    private lazy var announcementsTableView = UITableView(frame: .zero, style: .grouped).apply {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = AppColor.Theme.secondaryBackground.uiColor
        $0.register(type: NavigationCell.self)
        $0.register(type: AnnouncementCell.self)
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup Views

private extension MainScreenView {
    func setupViews() {
        addSubview(announcementsTableView)
    }
    
    func setupConstraints() {
        announcementsTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MainScreenView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.navigationItems.count : viewModel.announcementViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = NavigationCell(viewModel: viewModel.navigationCellViewModels[indexPath.row])
            return cell
        }
        if indexPath.section == 1 {
            let cell = AnnouncementCell(viewModel: viewModel.announcementViewModels[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? nil : MainSectionHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
