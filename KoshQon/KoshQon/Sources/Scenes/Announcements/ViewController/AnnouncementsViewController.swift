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
    
    private var deleteButtonSubscriber: AnyCancellable?
    
    private let viewModel: AnnouncementsViewModel
    private let type: AnnouncementsType
    
    override var navigationTitleType: NavigationTitleType? {
        return type == .favorites ? .favorites : .myAnnouncements
    }
    
    // MARK: - UI
    
    private lazy var announcementsView = AnnouncementsView(viewModel: viewModel, type: type)
    
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
}

// MARK: - Setup

private extension AnnouncementsViewController {
    func setupNavigation() {
        if type == .favorites {
            let deleteButton = UIBarButtonItem(
                barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped)
            )
            deleteButton.isEnabled = !viewModel.items.isEmpty
            navigationItem.rightBarButtonItem = deleteButton
        }
    }
    
    func setupBindings() {
        
    }
}

// MARK: - Actions

private extension AnnouncementsViewController {
    @objc func deleteButtonTapped() {
        didAnnouncementsDelete?({})
    }
    
}

