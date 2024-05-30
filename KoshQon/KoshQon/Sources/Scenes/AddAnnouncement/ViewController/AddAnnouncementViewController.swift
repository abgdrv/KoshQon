//
//  AddAnnouncementViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import SwiftUI
import SnapKit

final class AddAnnouncementViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didClose: VoidCallback?
    
    private let viewModel: AddAnnouncementViewModel
    
    // MARK: - UI
    
    private lazy var hostingController = UIHostingController(rootView: AddAnnouncementView(viewModel: viewModel))
    private lazy var addAnnouncementView = hostingController.view ?? UIView()
    
    private lazy var closeButton = UIBarButtonItem(
        title: LocalizableKeys.Alert.close.localized(),
        style: .plain,
        target: self,
        action: #selector(closeButtonTapped)
    ).apply {
        $0.tintColor = AppColor.Static.orange.uiColor
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: AddAnnouncementViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Setup

private extension AddAnnouncementViewController {
    func setupViews() {
        view.addSubview(addAnnouncementView)
        addAnnouncementView.backgroundColor = AppColor.Theme.mainBackground.uiColor
    }
    
    func setupConstraints() {
        addAnnouncementView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupNavigation() {
        navigationItem.rightBarButtonItem = closeButton
    }
}

// MARK: - Actions

private extension AddAnnouncementViewController {
    @objc func closeButtonTapped() {
        didClose?()
    }
}
