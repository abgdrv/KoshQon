//
//  MainScreenView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

final class MainScreenView: BaseView {
    
    // MARK: - Properties
    
    var didAnnouncementCellTap: Callback<AnnouncementViewModel>?
    var didNavigationCellTap: Callback<NavigationCellType>?
    
    var didScrollDown: VoidCallback?
    var didScrollUp: VoidCallback?
    
    var shouldAnimate = true
        
    private let viewModel: MainScreenViewModel
    
    private var lastVelocityYSign = 0
    
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
        super.init()
        setupViews()
        setupConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.shouldAnimate = false
            self.announcementsTableView.reloadData()
        }
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

// MARK: - UITableViewDelegate, UITableViewDataSource

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
            cell.didNavigationCellTap = { [weak self] type in
                guard let self = self else { return }
                self.didNavigationCellTap?(type)
            }
            return cell
        }
                
        let cell = AnnouncementCell(viewModel: viewModel.announcementViewModels[indexPath.row], isGradient: true)
        cell.didAnnouncementCellTap = { [weak self] viewModel in
            guard let self = self else { return }
            self.didAnnouncementCellTap?(viewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? nil : MainSectionHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 25
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentVelocityY = scrollView.panGestureRecognizer.velocity(in: scrollView.superview).y
        let currentVelocityYSign = Int(currentVelocityY).signum()
        if currentVelocityYSign != lastVelocityYSign, currentVelocityYSign != 0 {
            lastVelocityYSign = currentVelocityYSign
        }
        
        if lastVelocityYSign < 0 {
            didScrollDown?()
        } else if lastVelocityYSign > 0 {
            didScrollUp?()
        }
    }
}
