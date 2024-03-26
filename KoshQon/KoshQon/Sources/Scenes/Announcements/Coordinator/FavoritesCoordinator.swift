//
//  FavoritesCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation

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
        router.setRootModule(view)
    }
}
