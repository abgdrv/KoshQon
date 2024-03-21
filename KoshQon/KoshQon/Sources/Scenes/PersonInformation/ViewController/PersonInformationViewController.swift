//
//  PersonInformationViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 29.02.2024.
//

import UIKit
import Photos
import RSKImageCropper

final class PersonInformationViewController: BaseViewController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    private let viewModel: PersonInformationViewModel
        
    // MARK: - UI
    
    private lazy var personInformationView = PersonInformationView()
    private let imagePicker = UIImagePickerController()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: PersonInformationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = personInformationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupBindings()
    }
}

// MARK: - Setup

private extension PersonInformationViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: .personalInfo)
    }
    
    func setupBindings() {
        personInformationView.imageDidTap = { [weak self] in
            guard let self = self else { return }
            self.showImagePickerOptions()
        }
    }
}

// MARK: - Private methods

private extension PersonInformationViewController {
    func showImagePickerOptions() {
        let alert = UIAlertController(title: "Выберите фото",
                                        message: "Выберите фото из галереи или откройте камеру",
                                        preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                openImagePicker()
            }
        }
        let libraryAction = UIAlertAction(title: "Галерея", style: .default) { [weak self] _ in
            guard let self = self else { return }
            imagePicker.sourceType = .photoLibrary
            openImagePicker()
        }
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func openImagePicker() {
        PHPhotoLibrary.checkPermission(controller: self) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true)
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate

extension PersonInformationViewController: UIImagePickerControllerDelegate,
                                           RSKImageCropViewControllerDelegate {
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController,
                                 didCropImage croppedImage: UIImage,
                                 usingCropRect cropRect: CGRect,
                                 rotationAngle: CGFloat) {
        personInformationView.setProfileImage(image: croppedImage)
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ?? UIImage()
        picker.dismiss(animated: false) { [weak self] in
            guard let self = self else { return }
            let imageCropVC = RSKImageCropViewController(image: image, cropMode: .circle)
            imageCropVC.delegate = self
            self.navigationController?.pushViewController(imageCropVC, animated: true)
        }
    }
}
