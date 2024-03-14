//
//  FavoritesViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import UIKit

final class FavoritesViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: FavoritesViewModel
    
    // MARK: - UI
    
    private lazy var favoritesView = FavoritesView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Navigation

private extension FavoritesViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: .favorites)
    }
}
