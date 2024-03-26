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
    
    private let viewModel: ProfileViewModel
    
    // MARK: - UI
    
    private lazy var scrollView = UIScrollView().apply {
        $0.backgroundColor = AppColor.Theme.secondaryBackground.uiColor
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var topView = ProfileTopView(info: viewModel.main)
    private lazy var aboutView = ProfileAboutView(info: viewModel.about)
    private lazy var commonView = ProfileCommonView(info: viewModel.common)
    private lazy var announcementsView = ProfileAnnouncementsView(announcements: viewModel.items)
    
    private lazy var contentView = UIStackView(arrangedSubviews: [topView, aboutView,
                                                                  commonView, announcementsView]).apply {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ProfileViewModel) {
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
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}

extension ProfileView: UIScrollViewDelegate {
    
}
