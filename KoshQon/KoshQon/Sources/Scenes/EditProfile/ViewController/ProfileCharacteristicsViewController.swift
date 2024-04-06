//
//  ProfileCharacteristicsViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 06.04.2024.
//

import UIKit

final class ProfileCharacteristicsViewController: BaseViewController {

    // MARK: - Properties
    
    var didSave: VoidCallback?
    
    private let enabledChars: [CharacteristicType]
    
    override var navigationTitleType: NavigationTitleType? {
        return .characteristics
    }
    
    // MARK: - UI
    
    private lazy var profileCharacteristicsView = ProfileCharacteristicsView(enabledChars: enabledChars)
    
    // MARK: - Object Lifecycle
    
    init(enabledChars: [CharacteristicType]) {
        self.enabledChars = enabledChars
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = profileCharacteristicsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}


// MARK: - Setup

private extension ProfileCharacteristicsViewController {
    func setupBindings() {
        profileCharacteristicsView.didSave = { [weak self] chars in
            guard let self = self else { return }
            print(chars)
        }
    }
}

