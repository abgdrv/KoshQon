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
    
    private let isFirst: Bool
    private let router: RouterProtocol
    private let factory: MainScreenFlowFactory
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    // MARK: - Object Lifecycle
    
    init(isFirst: Bool, router: RouterProtocol, factory: MainScreenFlowFactory, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.isFirst = isFirst
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
        let view = factory.makeMainScreenView(isFirst: isFirst)
        
        view.didNavigationCellTap = { [weak self] type in
            guard let self = self else { return }
            self.openNavigationCell(type: type)
        }
        
        view.didAnnouncementCellTap = { [weak self] announcement in
            guard let self = self else { return }
            self.showAnnouncementDetails(announcement: announcement)
        }
        
        router.setRoodModule(view, hideNavBar: false, isAnimated: false)
    }
    
    func showSearch() {
        
    }
    
    func showMyAnnouncements() {
        let view = factory.makeAnnouncementsView(type: .myAnnouncements)
        router.push(view)
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
