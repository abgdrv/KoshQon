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
    var didShowImagePickerOptions: Callback<UIImagePickerController>?
    var didCancelCrop: VoidCallback?
    var didCropImage: VoidCallback?
    var didShowCropImage: Callback<RSKImageCropViewController>?
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate

extension EditProfileViewController: UIImagePickerControllerDelegate,
                                  RSKImageCropViewControllerDelegate,
                                  UINavigationControllerDelegate {
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        didCancelCrop?()
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController,
                                 didCropImage croppedImage: UIImage,
                                 usingCropRect cropRect: CGRect,
                                 rotationAngle: CGFloat) {
        editProfileView.setProfileImage(image: croppedImage)
        didCropImage?()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ?? UIImage()
        picker.dismiss(animated: false) { [weak self] in
            guard let self = self else { return }
            let imageCropVC = RSKImageCropViewController(image: image, cropMode: .circle)
            imageCropVC.delegate = self
            self.didShowCropImage?(imageCropVC)
        }
    }
}

// MARK: - Setup

private extension EditProfileViewController {
    func setupBindings() {
        editProfileView.didImageTap = { [weak self] in
            guard let self = self else { return }
            self.didShowImagePickerOptions?(self.imagePicker)
        }
    }
}
