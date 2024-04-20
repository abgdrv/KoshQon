//
//  AddAnnouncementViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import UIKit

final class AddAnnouncementViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didClose: VoidCallback?
    
    private let viewModel: AddAnnouncementViewModel
    
    // MARK: - UI
    
    private lazy var addAnnouncementView = AddAnnouncementView()
    
    private lazy var closeButton = UIBarButtonItem(
        title: "Закрыть",
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
    
    override func loadView() {
        super.loadView()
        view = addAnnouncementView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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

