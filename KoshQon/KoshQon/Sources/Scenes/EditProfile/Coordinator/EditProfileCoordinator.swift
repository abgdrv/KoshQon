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
        let view = factory.makeEditProfileView()
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
        
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.router.popModule()
        }
        
        router.push(view, hideBottomBar: true)
    }
    
    func showPhoneDetail() {
        var coordinator = coordinatorFactory.makeEnterPhoneCoordinator(type: .changePhone, router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.router.popModule(times: 2)
            ProgressHUD.success(LocalizableKeys.Alert.phoneChanged.localized())
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func showCharacteristicsDetail(enabledChars: [CharacteristicType]) {
        let view = factory.makeCharacteristicsView(enabledChars: enabledChars)
        view.didSave = { [weak self] in
            guard let self = self else { return }
            self.router.popModule()
        }
        router.push(view)
    }
    
    func showAboutDetail(existingText: String?) {
        let view = factory.makeAboutMeView(existingText: existingText)
        view.didSave = { [weak self] in
            guard let self = self else { return }
            self.router.popModule()
        }
        router.push(view)
    }
    
    func showProfileDetailCell(type: ProfileDetailType, value: [String]) {
        switch type {
        case .name:
            factory.showBanner(title: LocalizableKeys.Alert.changeName.localized(),
                               message: LocalizableKeys.Alert.support.localized(),
                               delay: 3)
        case .phone:
            showPhoneDetail()
        case .characteristics:
            showCharacteristicsDetail(enabledChars: value.map { CharacteristicType(rawValue: $0) ?? .alcohol })
        case .about:
            showAboutDetail(existingText: value[0])
        default:
            break
        }
    }
}
