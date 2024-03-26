//
//  AddAnnouncementViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import UIKit

final class AddAnnouncementViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: AddAnnouncementViewModel
    
    // MARK: - UI
    
    
    // MARK: - Object Lifecycle
    
    init(viewModel: AddAnnouncementViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
