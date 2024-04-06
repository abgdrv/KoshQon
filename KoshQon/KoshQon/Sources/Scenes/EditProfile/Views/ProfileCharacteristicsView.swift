//
//  ProfileCharacteristicsView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 06.04.2024.
//

import UIKit
import SnapKit

final class ProfileCharacteristicsView: BaseView {

    // MARK: - Properties
    
    var didSave: Callback<[CharacteristicType]>?
    
    private var characteristicsViews: [ProfileCharacteristicView] = []
    private var checkboxButtons: [UIButton] = []

    // MARK: - UI
    
    private lazy var characteristicsContainerView = UIStackView(arrangedSubviews: characteristicsViews).apply {
        $0.axis = .vertical
        $0.spacing = 15
    }
    
    private lazy var checkboxButtonsContainerView = UIStackView(arrangedSubviews: checkboxButtons).apply {
        $0.axis = .vertical
        $0.spacing = 15
        $0.distribution = .fillEqually
    }

    private lazy var saveButton = ProceedButton(type: .system).apply {
        $0.type = .save
        $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Object Lifecycle
    
    init(enabledChars: [CharacteristicType]) {
        super.init()
        self.characteristicsViews = getCharacteristicViews(enabledChars: enabledChars)
        setupViews()
        setupConstraints()
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
}

// MARK: - Setup Views

private extension ProfileCharacteristicsView {
    func setupViews() {
        addSubviews(characteristicsContainerView, checkboxButtonsContainerView, saveButton)
    }
    
    func setupConstraints() {
        characteristicsContainerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        checkboxButtonsContainerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(characteristicsContainerView.snp.trailing)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(characteristicsContainerView.snp.bottom)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

// MARK: - Private methods

private extension ProfileCharacteristicsView {
    func getCharacteristicViews(enabledChars: [CharacteristicType]) -> [ProfileCharacteristicView] {
        var views: [ProfileCharacteristicView] = []
        
        for caseValue in CharacteristicType.allCases {
            let view: ProfileCharacteristicView
            
            switch caseValue {
            case .good, .responsible, .clean:
                break
            default:
                view = ProfileCharacteristicView(type: caseValue, isLarge: true)
                views.append(view)
                
                let checkboxButton = UIButton(type: .custom).apply {
                    $0.setImage(AppImage.Common.checkbox.uiImage, for: .normal)
                    $0.setImage(AppImage.Common.checkboxSelected.uiImage, for: .selected)
                    $0.addTarget(self, action: #selector(checkboxButtonTapped(_ :)), for: .touchUpInside)
                }
                if enabledChars.contains(caseValue) {
                    checkboxButton.isSelected = true
                }
                checkboxButtons.append(checkboxButton)
            }
        }
        
        return views
    }
}

// MARK: - Actions

private extension ProfileCharacteristicsView {
    @objc func checkboxButtonTapped(_ button: UIButton) {
        button.isSelected.toggle()
    }
    
    @objc func saveButtonTapped() {
        var savedChars: [CharacteristicType] = []
        for index in 0..<checkboxButtons.count {
            if checkboxButtons[index].isSelected {
                savedChars.append(characteristicsViews[index].type)
            }
        }
        didSave?(savedChars)
    }
}
