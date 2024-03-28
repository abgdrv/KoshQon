//
//  EditProfileCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

final class EditProfileCoordinator: BaseCoordinator, EditProfileOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    var profile: Profile?
    
    private let router: RouterProtocol
    private let factory: EditProfileFlowFactory
        
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: EditProfileFlowFactory) {
        self.router = router
        self.factory = factory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showEditProfile()
    }
}

private extension EditProfileCoordinator {
    func showEditProfile() {
        guard let profile = profile else { return }
        let view = factory.makeEditProfileView(profile: profile)
        router.push(view)
    }
}
