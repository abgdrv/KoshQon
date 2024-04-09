//
//  EditProfileViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import UIKit
import SnapKit
import RSKImageCropper

final class EditProfileViewController: BaseViewController, ImageSettable {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    var didProfileDetailCellTap: PairCallback<ProfileDetailType, [String]>?
    var didImagePickerOptionsShow: PairCallback<UIImagePickerController, Bool>?
    var didCropCancel: VoidCallback?
    var didImageCrop: VoidCallback?
    var didCropImageShow: Callback<RSKImageCropViewController>?
    var didImageDelete: VoidCallback? {
        didSet {
            profileImageView.image = AppImage.Personal.defaultProfile.uiImage
        }
    }
    
    var image: UIImage? {
        return profileImageView.image
    }
    
    private let viewModel: EditProfileViewModel
    
    private var isImageSelected: Bool {
        profileImageView.image != AppImage.Personal.defaultProfile.uiImage
    }
    
    override var navigationTitleType: NavigationTitleType? {
        return .personalInfo
    }
    
    // MARK: - UI
    
    private lazy var profileImageView = ProfileImageView(image: nil, isEditable: true)
    
    private lazy var detailsContainerView = UIView().apply {
        $0.backgroundColor = AppColor.Theme.secondaryBackground.uiColor
    }
    
    private lazy var detailsTableView = DynamicTableView(style: .plain).apply {
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UIDevice.current.isSmall ? 40 : 50
        $0.isScrollEnabled = false
        $0.register(type: ProfileDetailCell.self)
    }
    
    private lazy var saveButton = ProceedButton(type: .system).apply {
        $0.type = .save
        $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private lazy var imagePicker = UIImagePickerController().apply { $0.delegate = self }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailsTableView.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProfileDetailCell(viewModel: viewModel.items[indexPath.row])
        cell.didProfileDetailCellTap = { [weak self] type, value in
            guard let self = self else { return }
            self.didProfileDetailCellTap?(type, value)
        }
        return cell
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
        profileImageView.image = croppedImage
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

// MARK: - Setup Views

private extension EditProfileViewController {
    func setupViews() {
        view.addSubviews(profileImageView, detailsContainerView, saveButton)
        detailsContainerView.addSubview(detailsTableView)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        
        detailsContainerView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        detailsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    func setupBindings() {
        profileImageView.didImageTap = { [weak self] in
            guard let self = self else { return }
            self.didImagePickerOptionsShow?(self.imagePicker, self.isImageSelected)
        }
    }
}

// MARK: - Actions

private extension EditProfileViewController {
    @objc func saveButtonTapped() {
        didFinish?()
    }
}
