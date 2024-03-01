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
    
    private var options: [BottomSheetOption] = []
        
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
        setupBindings()
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
            let longFomTypes: [InputType] = [.city, .phone]
            if type == .gender {
                self.options = [BottomSheetOption(primeText: "Мужской"), BottomSheetOption(primeText: "Женский")]
            }
            if type == .city {
                self.options = [BottomSheetOption(primeText: "Алматы"), BottomSheetOption(primeText: "Астана"), BottomSheetOption(primeText: "Алматы"), BottomSheetOption(primeText: "Астана"), BottomSheetOption(primeText: "Алматы"), BottomSheetOption(primeText: "Астана"), BottomSheetOption(primeText: "Алматы"), BottomSheetOption(primeText: "Астана"), BottomSheetOption(primeText: "Алматы"), BottomSheetOption(primeText: "Астана"), BottomSheetOption(primeText: "Алматы"), BottomSheetOption(primeText: "Астана"),BottomSheetOption(primeText: "Алматы"), BottomSheetOption(primeText: "Астана")]
            }
            presentPanModal(BottomSheetViewController(options: options, isLong: longFomTypes.contains(type)))
        }
    }
}
