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
    
    lazy var topView = ProfileTopView(viewModel: viewModel)
    lazy var aboutView = ProfileAboutView(viewModel: viewModel)
    lazy var commonView = ProfileCommonView(viewModel: viewModel)
//    lazy var announcementsView = ProfileAnnouncementsView(announcementViewModels: viewModel.items)
    
    private lazy var contentView = UIStackView().apply {
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
        
        contentView.addArrangedSubview(topView)
        if !AppData.shared.user.about.isEmpty {
            contentView.addArrangedSubview(aboutView)
        }
        contentView.addArrangedSubview(commonView)
//        if !AppData.shared.myAnnouncements.isEmpty {
//            contentView.addArrangedSubview(announcementsView)
//        }
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
