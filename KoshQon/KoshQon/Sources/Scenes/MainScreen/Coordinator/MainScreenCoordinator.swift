//
//  MainScreenCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 25.03.2024.
//

import Foundation

final class MainScreenCoordinator: BaseCoordinator, MainScreenOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    var reloadFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: MainScreenFlowFactory
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: MainScreenFlowFactory, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showMainScreen()
    }
}

private extension MainScreenCoordinator {
    func showMainScreen() {
        let view = factory.makeMainScreenView()
        view.didNavigationCellTap = { [weak self] type in
            guard let self = self else { return }
            self.openNavigationCell(type: type)
        }
        router.setRoodModule(view, hideNavBar: false, isAnimated: false)
    }
    
    func showSearch() {
        
    }
    
    func showMyAnnouncements() {
        
    }
    
    func showGuide() {
        
    }
    
    func openNavigationCell(type: NavigationCellType) {
        switch type {
        case .main(let mainType):
            switch mainType {
            case .search:
                showSearch()
            case .myAnnouncements:
                showMyAnnouncements()
            case .guide:
                showGuide()
            }
        default:
            break
        }
    }
}
