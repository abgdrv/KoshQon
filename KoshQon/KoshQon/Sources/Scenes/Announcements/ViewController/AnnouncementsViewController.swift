//
//  AnnouncementsViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import UIKit

final class AnnouncementsViewController: BaseViewController {
    
    // MARK: - Properties
    
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
    }
}
