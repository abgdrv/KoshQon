//
//  EditProfileCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation
import ProgressHUD

final class EditProfileCoordinator: ImageSetCoordinator, EditProfileOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    var profile: Profile?
    
    private let router: RouterProtocol
    private let factory: EditProfileFlowFactory
    private let coordinatorFactory: CoordinatorFactory
        
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: EditProfileFlowFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router, factory: factory)
    }
    
    override func start() {
        showEditProfile()
    }
}

private extension EditProfileCoordinator {
    func showEditProfile() {
        guard let profile = profile else { return }
        let view = factory.makeEditProfileView(profile: profile)
        view.didProfileDetailCellTap = { [weak self] type, value in
            guard let self = self else { return }
            self.showProfileDetailCell(type: type, value: value)
        }
        view.didImagePickerOptionsShow = { [weak self] picker, isImageSelected in
            guard let self = self else { return }
            self.showImagePickerOptions(picker: picker, view: view, isImageSelected: isImageSelected)
        }
        view.didCropCancel = { [weak self] in
            guard let self = self else { return }
            self.router.popModule()
        }
        view.didImageCrop = { [weak self] in
            guard let self = self else { return }
            self.router.popModule()
        }
        view.didCropImageShow = { [weak self] cropImage in
            guard let self = self else { return }
            self.router.push(cropImage)
        }
        router.push(view)
    }
    
    func showPhoneDetail() {
        var coordinator = coordinatorFactory.makeEnterPhoneCoordinator(type: .changePhone, router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.router.popModule(times: 2)
            ProgressHUD.success("Номер изменен")
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func showCharacteristicsDetail() {
        let view = factory.makeCharacteristicsView(enabledChars: [])
        view.didSave = { [weak self] in
            guard let self = self else { return }
        }
        router.push(view)
    }
    
    func showAboutDetail(existingText: String?) {
        let view = factory.makeAboutMeView(existingText: nil)
        view.didSave = { [weak self] in
            guard let self = self else { return }
        }
        router.push(view)
    }
    
    func showProfileDetailCell(type: ProfileDetailType, value: String?) {
        switch type {
        case .name:
            factory.showBanner(title: "Хотите изменить имя?",
                               message: "Для этого вы можете обратиться в техподдержку",
                               delay: 3)
        case .phone:
            showPhoneDetail()
        case .characteristics:
            showCharacteristicsDetail()
        case .about:
            showAboutDetail(existingText: value)
        default:
            break
        }
    }
}
