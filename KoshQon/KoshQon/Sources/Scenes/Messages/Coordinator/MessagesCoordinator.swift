//
//  MessagesCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.05.2024.
//

import Foundation

final class MessagesCoordinator: BaseCoordinator, MessagesOutputCoordinator {
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: MessagesFlowFactory
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    init(router: RouterProtocol, factory: MessagesFlowFactory, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showMessages()
    }
}

private extension MessagesCoordinator {
    func showMessages() {
        let view = factory.makeMessagesView(isATCChat: false)
        router.setRoodModule(view, hideNavBar: false, isAnimated: false)
    }
    
    func showATCChat() {
        let view = factory.makeMessagesView(isATCChat: true)
        router.setRoodModule(view, hideNavBar: false, isAnimated: false)
    }
}
