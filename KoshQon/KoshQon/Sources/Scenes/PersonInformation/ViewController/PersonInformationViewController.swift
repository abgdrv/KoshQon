//
//  PersonInformationViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 29.02.2024.
//

import UIKit
import PanModal

final class PersonInformationViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI
    
    private lazy var personInformationView = PersonInformationView()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = personInformationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Setup

private extension PersonInformationViewController {
    func setupNavigation() {
        let navigationTitle = NavigationTitleView(type: .personalInfo)
        navigationItem.titleView = navigationTitle
    }
    
    func setupBindings() {
        personInformationView.onAction = { [weak self] type in
            guard let self = self else { return }
            if type == .date {
                
            }
        }
    }
}
