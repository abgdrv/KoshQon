//
//  AnnouncementsCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation
import UIKit

final class AnnouncementsCoordinator: BaseCoordinator, AnnouncementsOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: AnnouncementsFlowFactory
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: AnnouncementsFlowFactory, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showFavorites()
    }
}

private extension AnnouncementsCoordinator {
    func showFavorites() {
        let view = factory.makeAnnouncementsView(type: .favorites)
        
        view.didAnnouncementsDelete = { [weak self] completion in
            guard let self = self else { return }
            self.showDeleteAlert(completion: completion)
        }
        
        view.didAnnouncementCellTap = { [weak self] announcement in
            guard let self = self else { return }
            self.showAnnouncementDetails(announcement: announcement)
        }
        
        router.setRoodModule(view, hideNavBar: false, isAnimated: false)
    }
    
    func showDeleteAlert(completion: @escaping VoidCallback) {
        let actions: [UIAlertAction] = [
            UIAlertAction(title: LocalizableKeys.Alert.delete.localized(), style: .destructive, handler: { action in
                completion()
            }),
            UIAlertAction(title: LocalizableKeys.Alert.cancel.localized(), style: .cancel, handler: { action in
                self.router.dismissModule()
            })
        ]
        let alert = factory.makeAlert(title: LocalizableKeys.Alert.deleteFavorites.localized(), message: nil, with: actions)
        router.toPresent()?.present(alert, animated: true)
    }
    
    func showAnnouncementDetails(announcement: Announcement) {
        var coordinator = coordinatorFactory.makeAnnouncementDetailsCoordinator(announcement: announcement, router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.finishFlow?()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
