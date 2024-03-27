//
//  AddAnnouncementCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation
import UIKit

final class AddAnnouncementCoordinator: BaseCoordinator, AddAnnouncementOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: AddAnnouncementFlowFactory
        
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: AddAnnouncementFlowFactory) {
        self.router = router
        self.factory = factory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showAddAnnouncement()
    }
}

private extension AddAnnouncementCoordinator {
    func showAddAnnouncement() {
        let view = factory.makeAddAnnouncementView()
        view.didClose = { [weak self] in
            guard let self = self else { return }
            self.router.dismissModule()
        }
        let root = UINavigationController(rootViewController: view)
        router.present(root)
    }
}
