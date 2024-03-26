//
//  AnnouncementsView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import UIKit
import SnapKit

final class AnnouncementsView: BaseView {

    // MARK: - Properties
    
    private let viewModel: AnnouncementsViewModel
    private let type: AnnouncementsType
    
    // MARK: - UI
    
    private lazy var announcementsTableView = UITableView(frame: .zero, style: .plain).apply {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = AppColor.Theme.secondaryBackground.uiColor
        $0.register(type: AnnouncementCell.self)
    }
    
    private lazy var heartImageView = UIImageView(image: AppImage.Favorites.heart.uiImage).apply {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.semibold.s24, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = "Место для избранного"
        $0.textAlignment = .center
    }
    
    private lazy var infoLabel = InfoLabel(type: .favorites)
    
    private lazy var findButton = ProceedButton(type: .system).apply {
        $0.type = .find
        $0.addTarget(self, action: #selector(findButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: AnnouncementsViewModel, type: AnnouncementsType) {
        self.viewModel = viewModel
        self.type = type
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
        findButton.layer.cornerRadius = 10
    }
}

// MARK: - Setup Views

private extension AnnouncementsView {
    func setupViews() {
        if viewModel.ads.isEmpty {
            addSubviews(heartImageView, titleLabel, infoLabel, findButton)
        } else {
            addSubview(announcementsTableView)
        }
    }
    
    func setupConstraints() {
        if viewModel.ads.isEmpty {
            findButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(50)
            }
            
            infoLabel.snp.makeConstraints { make in
                make.bottom.equalTo(findButton.snp.top).offset(-8)
                make.leading.equalTo(findButton.snp.leading).offset(10)
                make.trailing.equalTo(findButton.snp.trailing).offset(-10)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.bottom.equalTo(infoLabel.snp.top).offset(-8)
                make.leading.equalTo(findButton.snp.leading).offset(32)
                make.trailing.equalTo(findButton.snp.trailing).offset(-32)
            }
            
            heartImageView.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel.snp.top).offset(-8)
                make.centerX.equalToSuperview()
            }
        } else {
            announcementsTableView.snp.makeConstraints { make in
                make.top.equalTo(safeAreaLayoutGuide.snp.top)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension AnnouncementsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AnnouncementCell(viewModel: viewModel.items[indexPath.row])
        return cell
    }
}

// MARK: - Actions

private extension AnnouncementsView {
    @objc func findButtonTapped() {
        
    }
}
