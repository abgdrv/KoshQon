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
    
    // MARK: - Object Lifecycle
    
    init(viewModel: AddAnnouncementViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
}

// MARK: - Setup

private extension AddAnnouncementViewController {
    func setupNavigation() {
        let closeButton = UIBarButtonItem(title: "Закрыть", style: .plain, target: self,
                                          action: #selector(closeButtonTapped))
        closeButton.tintColor = AppColor.Static.orange.uiColor
        navigationItem.rightBarButtonItem = closeButton
    }
}

// MARK: - Actions

private extension AddAnnouncementViewController {
    @objc func closeButtonTapped() {
        didClose?()
    }
}

