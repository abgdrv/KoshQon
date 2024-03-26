//
//  BaseViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.02.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    var navigationType: NavigationTitleType? {
        return nil
    }
    
    var navigationTitle: String? {
        return nil
    }
    
    // MARK: - Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented!")
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Navigation

private extension BaseViewController {
    func setupNavigation() {
        let backButtonImage = AppImage.Common.backArrow.uiImage?
            .withRenderingMode(.alwaysTemplate)
            .withAlignmentRectInsets(UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
        
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationController?.navigationBar.tintColor = AppColor.Theme.mainTitle.uiColor
        navigationController?.navigationBar.backgroundColor = AppColor.Theme.mainBackground.uiColor
        
        let titleView = NavigationTitleView(type: navigationType)
        if navigationType == .directMessages {
            titleView.title = navigationTitle
        }
        navigationItem.titleView = titleView
        navigationItem.title = titleView.title
        navigationItem.backButtonDisplayMode = .minimal
    }
}
