//
//  EditProfileView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import UIKit
import SnapKit

final class EditProfileView: BaseView {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    
    private let viewModel: EditProfileViewModel
    
    // MARK: - UI
    
    private lazy var profileImageView = ProfileImageView(image: nil, isEditable: true)
    
    private lazy var detailsContainerView = UIView().apply {
        $0.backgroundColor = AppColor.Theme.secondaryBackground.uiColor
    }
    
    private lazy var detailsTableView = DynamicTableView(style: .plain).apply {
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UIDevice.current.isSmall ? 40 : 50
        $0.isScrollEnabled = false
        $0.register(type: ProfileDetailsCell.self)
    }
    
    private lazy var saveButton = ProceedButton(type: .system).apply {
        $0.type = .save
        $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        super.init()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        detailsTableView.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension EditProfileView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProfileDetailsCell(viewModel: viewModel.items[indexPath.row])
        return cell
    }
}

// MARK: - Setup Views

private extension EditProfileView {
    func setupViews() {
        addSubviews(profileImageView, detailsContainerView, saveButton)
        detailsContainerView.addSubviews(detailsTableView)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        
        detailsContainerView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        detailsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

// MARK: - Actions

private extension EditProfileView {
    @objc func saveButtonTapped() {
        didFinish?()
    }
}