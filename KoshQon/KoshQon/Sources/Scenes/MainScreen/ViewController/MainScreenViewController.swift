//
//  MainScreenViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit

final class MainScreenViewController: BaseViewController {
    
    // MARK: - Properties
    
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
    }
}
