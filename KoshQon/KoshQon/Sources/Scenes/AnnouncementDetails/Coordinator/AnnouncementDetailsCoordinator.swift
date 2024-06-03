//
//  AnnouncementDetailsCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 02.06.2024.
//

import Foundation

final class AnnouncementDetailsCoordinator: BaseCoordinator, AnnouncementDetailsOutputCoordinator {
    
    var finishFlow: VoidCallback?
    
    private let announcement: Announcement
    
    private let router: RouterProtocol
    private let factory: AnnouncementDetailsFlowFactory
    
    init(announcement: Announcement, router: RouterProtocol, factory: AnnouncementDetailsFlowFactory) {
        self.announcement = announcement
        self.router = router
        self.factory = factory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showAnnouncementDetails()
    }
}

private extension AnnouncementDetailsCoordinator {
    func showAnnouncementDetails() {
        let view = factory.makeAnnouncementDetailsView(announcement: announcement)
        
        view.didProfileTap = { [weak self] user in
            guard let self = self else { return }
            self.showProfile(user: user)
        }
        
        router.push(view, hideBottomBar: true)
    }
    
    func showProfile(user: User) {
        let view = factory.makeProfileView(type: .userProfile, user: user)
        router.push(view)
    }
}
