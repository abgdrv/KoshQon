//
//  EditProfileViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import UIKit
import RSKImageCropper

final class EditProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    var didProfileDetailCellTap: PairCallback<ProfileDetailType, String>?
    var didImagePickerOptionsShow: PairCallback<UIImagePickerController, Bool>?
    var didCropCancel: VoidCallback?
    var didImageCrop: VoidCallback?
    var didCropImageShow: Callback<RSKImageCropViewController>?
    var didImageDelete: VoidCallback? {
        didSet {
            editProfileView.setProfileImage(image: AppImage.Personal.defaultProfile.uiImage)
        }
    }
    
    private let viewModel: EditProfileViewModel
    
    override var navigationTitleType: NavigationTitleType? {
        return .personalInfo
    }
    
    // MARK: - UI
    
    private lazy var editProfileView = EditProfileView(viewModel: viewModel)
    private lazy var imagePicker = UIImagePickerController().apply { $0.delegate = self }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = editProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate

extension EditProfileViewController: UIImagePickerControllerDelegate,
                                  RSKImageCropViewControllerDelegate,
                                  UINavigationControllerDelegate {
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        didCropCancel?()
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController,
                                 didCropImage croppedImage: UIImage,
                                 usingCropRect cropRect: CGRect,
                                 rotationAngle: CGFloat) {
        editProfileView.setProfileImage(image: croppedImage)
        didImageCrop?()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ?? UIImage()
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let imageCropVC = RSKImageCropViewController(image: image, cropMode: .circle)
            imageCropVC.delegate = self
            self.didCropImageShow?(imageCropVC)
        }
    }
}

// MARK: - Setup

private extension EditProfileViewController {
    func setupBindings() {
        editProfileView.didImageTap = { [weak self] isImageSelected in
            guard let self = self else { return }
            self.didImagePickerOptionsShow?(self.imagePicker, isImageSelected)
        }
        
        editProfileView.didProfileDetailCellTap = { [weak self] type, value in
            guard let self = self else { return }
            self.didProfileDetailCellTap?(type, value)
        }
    }
}
