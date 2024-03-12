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
    
    // MARK: - UI
    
    private lazy var mainTableView = UITableView(frame: .zero, style: .grouped).apply {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = AppColor.Theme.secondaryBackground.uiColor
        $0.registerCell(MainNavigationCell.self)
        $0.registerCell(AdvertisementCell.self)
    }
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubviews(mainTableView)
    }
    
    func setupConstraints() {
        mainTableView.snp.makeConstraints { make in
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
        section == 0 ? Mock.navigationItems.count : Mock.ads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueCell(MainNavigationCell.self, indexPath: indexPath)
            let item = Mock.navigationItems[indexPath.row]
            cell.configure(iconImage: item.image, title: item.title)
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueCell(AdvertisementCell.self, indexPath: indexPath)
            let item = Mock.ads[indexPath.row]
            cell.configure(ad: item)
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

extension MainScreenView {
    private struct Mock {
        static let navigationItems = [
            MainNavigationItem(type: .search),
            MainNavigationItem(type: .advertisements),
            MainNavigationItem(type: .guide)
        ]
        
        static let ads = [
            Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: "8.7"),
            Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: "8.7"),
            Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: "8.7"),
            Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: "8.7")
        ]
    }
}
