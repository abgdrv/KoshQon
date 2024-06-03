//
//  FriendsCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 10.04.2024.
//

import Foundation

final class FriendsCoordinator: BaseCoordinator, FriendsOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: FriendsFlowFactory
    private let coordinatorFactory: CoordinatorFactory
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: FriendsFlowFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showFriends()
    }
}

private extension FriendsCoordinator {
    func showFriends() {
        let view = factory.makeFriendsView()
        view.didFriendCellTap = { [weak self] id in
            guard let self = self else { return }
        }
        router.push(view)
    }
}
