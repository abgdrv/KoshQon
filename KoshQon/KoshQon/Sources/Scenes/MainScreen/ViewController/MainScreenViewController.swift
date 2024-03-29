//
//  MainScreenViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit

final class MainScreenViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didNavigationCellTap: Callback<NavigationCellType>?
    var didAnnouncementCellTap: Callback<AnnouncementViewModel>?
    
    private let viewModel: MainScreenViewModel
    
    override var navigationTitleType: NavigationTitleType? {
        return .main
    }
        
    // MARK: - UI
    
    private lazy var mainScreenView = MainScreenView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = mainScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}

private extension MainScreenViewController {
    func setupBindings() {
        mainScreenView.didNavigationCellTap = { [weak self] type in
            guard let self = self else { return }
            self.didNavigationCellTap?(type)
        }
        
        mainScreenView.didAnnouncementCellTap = { [weak self] viewModel in
            guard let self = self else { return }
            self.didAnnouncementCellTap?(viewModel)
        }
    }
}
