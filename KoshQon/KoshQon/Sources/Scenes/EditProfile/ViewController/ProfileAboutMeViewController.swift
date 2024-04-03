//
//  ProfileAboutMeViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.04.2024.
//

import UIKit

final class ProfileAboutMeViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didSave: VoidCallback?
    
    private let existingText: String
    
    override var navigationTitleType: NavigationTitleType? {
        return .aboutMe
    }
    
    // MARK: - UI
    
    private lazy var profileAboutMeView = ProfileAboutMeView(existingText: existingText)
    
    // MARK: - Object Lifecycle
    
    init(existingText: String? = nil) {
        self.existingText = existingText ?? ""
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = profileAboutMeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}

// MARK: - Setup

private extension ProfileAboutMeViewController {
    func setupBindings() {
        profileAboutMeView.didSave = { [weak self] in
            guard let self = self else { return }
            self.didSave?()
        }
    }
}
