//
//  SettingsViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import UIKit

final class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: SettingsViewModel
    
    // MARK: - UI
    
    
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
