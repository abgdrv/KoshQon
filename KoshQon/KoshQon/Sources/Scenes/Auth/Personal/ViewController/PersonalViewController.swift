//
//  PersonalViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 29.02.2024.
//

import UIKit
import RSKImageCropper

final class PersonalViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    var didShowImagePickerOptions: Callback<UIImagePickerController>?
    var didCancelCrop: VoidCallback?
    var didCropImage: VoidCallback?
    var didShowCropImage: Callback<RSKImageCropViewController>?
    
    private let viewModel: PersonalViewModel
    
    override var navigationTitleType: NavigationTitleType? {
        return .personalInfo
    }
    
    // MARK: - UI
    
    private lazy var personalView = PersonalView()
    private lazy var imagePicker = UIImagePickerController().apply { $0.delegate = self }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: PersonalViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = personalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}

// MARK: - Setup

private extension PersonalViewController {
    func setupBindings() {
        personalView.didFinish = { [weak self] in
            guard let self = self else { return }
            self.didFinish?()
        }
        
        personalView.didImageTap = { [weak self] in
            guard let self = self else { return }
            self.didShowImagePickerOptions?(self.imagePicker)
        }        
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate

extension PersonalViewController: UIImagePickerControllerDelegate,
                                  RSKImageCropViewControllerDelegate,
                                  UINavigationControllerDelegate {
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        didCancelCrop?()
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController,
                                 didCropImage croppedImage: UIImage,
                                 usingCropRect cropRect: CGRect,
                                 rotationAngle: CGFloat) {
        personalView.setProfileImage(image: croppedImage)
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
