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
    
    private lazy var advertisementsTableView = UITableView(frame: .zero, style: .grouped).apply {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = AppColor.Theme.secondaryBackground.uiColor
        $0.register(type: MainNavigationCell.self)
        $0.register(type: AdvertisementCell.self)
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views

private extension MainScreenView {
    func setupViews() {
        addSubview(advertisementsTableView)
    }
    
    func setupConstraints() {
        advertisementsTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MainScreenView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? viewModel.navigationItems.count : viewModel.ads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeue(type: MainNavigationCell.self, for: indexPath)
            let item = viewModel.navigationItems[indexPath.row]
            cell.configure(iconImage: item.image, title: item.title)
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeue(type: AdvertisementCell.self, for: indexPath)
            cell.configure(ad: viewModel.ads[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 0 ? nil : MainSectionHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 0 : 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
