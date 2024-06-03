//
//  AnnouncementsViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import UIKit
import Combine

final class AnnouncementsViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didAnnouncementsDelete: Callback<VoidCallback>?
    var didAnnouncementCellTap: Callback<Announcement>?
    
    private var deleteButtonSubscriber: AnyCancellable?
    
    private let viewModel: AnnouncementsViewModel
    private let type: AnnouncementsType
    
    override var navigationTitleType: NavigationTitleType? {
        return NavigationTitleType(rawValue: type.rawValue)
    }
    
    // MARK: - UI
    
    private lazy var announcementsView = AnnouncementsView(viewModel: viewModel, type: type)
    
    private lazy var deleteButton = UIBarButtonItem(
        barButtonSystemItem: .trash,
        target: self,
        action: #selector(deleteButtonTapped)
    )
    
    // MARK: - Object Lifecycle
    
    init(viewModel: AnnouncementsViewModel, type: AnnouncementsType) {
        self.viewModel = viewModel
        self.type = type
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = announcementsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAnnouncements()
        announcementsView = AnnouncementsView(viewModel: viewModel, type: type)
        view = announcementsView
        announcementsView.announcementsTableView.reloadData()
        setupBindings()
        setupNavigation()
    }
}

// MARK: - Setup

private extension AnnouncementsViewController {
    func setupNavigation() {
        if type == .favorites {
            deleteButton.isEnabled = !viewModel.items.isEmpty
            navigationItem.rightBarButtonItem = deleteButton
        }
    }
    
    func setupBindings() {
        announcementsView.didAnnouncementCellTap = { [weak self] announcement in
            guard let self = self else { return }
            self.didAnnouncementCellTap?(announcement)
        }
    }
}

// MARK: - Actions

private extension AnnouncementsViewController {
    @objc func deleteButtonTapped() {
        didAnnouncementsDelete?({ [weak self] in
            AppData.shared.favorites.removeAll()
            self?.viewWillAppear(true)
        })
    }
    
}

