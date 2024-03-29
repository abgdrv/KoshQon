//
//  FavoritesCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation
import UIKit

final class FavoritesCoordinator: BaseCoordinator, FavoritesOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: FavoritesFlowFactory
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: FavoritesFlowFactory, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showFavorites()
    }
}

private extension FavoritesCoordinator {
    func showFavorites() {
        let view = factory.makeFavoritesView(type: .favorites)
        view.didAnnouncementsDelete = { [weak self] completion in
            guard let self = self else { return }
            self.showDeleteAlert(completion: completion)
        }
        router.setRoodModule(view, hideNavBar: false, isAnimated: false)
    }
    
    func showDeleteAlert(completion: @escaping VoidCallback) {
        let actions: [UIAlertAction] = [
            UIAlertAction(title: "Удалить", style: .destructive, handler: { action in
                completion()
            }),
            UIAlertAction(title: "Отмена", style: .cancel, handler: { action in
                self.router.dismissModule()
            })
        ]
        let alert = factory.makeAlert(title: "Удалить все избранное?", message: nil, with: actions)
        router.toPresent()?.present(alert, animated: true)
    }
}
