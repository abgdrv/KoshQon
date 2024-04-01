//
//  ProfileAnnouncementsView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.03.2024.
//

import UIKit
import SnapKit

final class ProfileAnnouncementsView: HighlightView {
        
    // MARK: - Properties
    
    private var announcementViewModels: [AnnouncementViewModel]
    
    // MARK: - UI
    
    private lazy var containerView = UIView().apply {
        $0.backgroundColor = AppColor.Theme.blockBackground.uiColor
    }
    
    private lazy var announcementsTitleLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s20, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = "Объявления"
    }
    
    private lazy var announcementsTableView = DynamicTableView(style: .plain).apply {
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = AppColor.Theme.blockBackground.uiColor
        $0.register(type: AnnouncementCell.self)
    }
    
    // MARK: - Object Lifecycle
    
    init(announcementViewModels: [AnnouncementViewModel]) {
        self.announcementViewModels = announcementViewModels
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 10
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProfileAnnouncementsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AnnouncementCell(viewModel: announcementViewModels[indexPath.row])
        return cell
    }
}

// MARK: - Setup Views

private extension ProfileAnnouncementsView {
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(announcementsTitleLabel, announcementsTableView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        announcementsTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        announcementsTableView.snp.makeConstraints { make in
            make.top.equalTo(announcementsTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
