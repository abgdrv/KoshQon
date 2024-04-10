//
//  ProfileView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {

    // MARK: - Properties
    
    var didFriendsTap: VoidCallback?
    
    private let viewModel: ProfileViewModel
    
    // MARK: - UI
    
    private lazy var scrollView = UIScrollView().apply {
        $0.backgroundColor = AppColor.Theme.secondaryBackground.uiColor
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var topView = ProfileTopView(info: viewModel.profile?.mainInfo)
    private lazy var aboutView = ProfileAboutView(info: viewModel.profile?.aboutInfo)
    private lazy var commonView = ProfileCommonView(info: viewModel.profile?.commonInfo)
    private lazy var announcementsView = ProfileAnnouncementsView(announcementViewModels: viewModel.items)
    
    private lazy var contentView = UIStackView(
        arrangedSubviews: [topView, aboutView, commonView, announcementsView]
    ).apply {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init()
        setupViews()
        setupConstraints()
        setupBindings()
    }
}

// MARK: - Setup Views

private extension ProfileView {
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.width.equalToSuperview()
        }
    }
    
    func setupBindings() {
        topView.didFriendsTap = { [weak self] in
            guard let self = self else { return }
            self.didFriendsTap?()
        }
    }
}
