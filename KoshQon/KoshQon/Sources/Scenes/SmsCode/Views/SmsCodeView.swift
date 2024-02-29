//
//  SmsCodeView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.02.2024.
//

import UIKit
import SnapKit
import ProgressHUD

final class SmsCodeView: BaseView {
    
    // MARK: - Properties
    
    var onAction: VoidCallback?
    
    private let viewModel: SmsCodeViewModel
    private var codeTextFields: [UITextField] = []
    private var resendTimer = Timer()
    
    private var code: String {
        var code = ""
        codeTextFields.forEach { code += $0.text ?? "" }
        return code
    }
    
    // MARK: - UI
    
    private lazy var infoLabel = InfoLabel(type: .sms)
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+7 (777) 777 77 77"
        label.font = AppFont.medium.s20
        label.textColor = AppColor.Theme.mainTitle.uiColor
        return label
    }()
    
    private lazy var codeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        for _ in 0..<4 {
            let textField = InputTextField(inputType: .sms)
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            stackView.addArrangedSubview(textField)
            codeTextFields.append(textField)
        }
        return stackView
    }()
    
    private lazy var resendLabel = InfoLabel(type: .resend)
    
    private lazy var resendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(viewModel.timeString, for: .normal)
        button.setTitleColor(AppColor.Static.darkBlue.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.medium.s16
        button.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueButton: ProceedButton = {
        let button = ProceedButton(type: .system)
        button.type = .continue
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SmsCodeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setupObservers()
        setupTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        resendButton.isEnabled = !viewModel.isTimerRunning()
        codeTextFields.forEach { $0.layer.cornerRadius = 12 }
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }
}

// MARK: - Setup

private extension SmsCodeView {
    func setupViews() {
        backgroundColor = AppColor.Theme.mainBackground.uiColor
        [infoLabel, phoneNumberLabel, codeStackView,
         resendLabel, resendButton, continueButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(70)
            make.centerX.equalToSuperview()
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        codeStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        resendLabel.snp.makeConstraints { make in
            make.top.equalTo(codeStackView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        resendButton.snp.makeConstraints { make in
            make.top.equalTo(resendLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    func setupTimer() {
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer),
                                           userInfo: nil, repeats: true)
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Actions

private extension SmsCodeView {
    @objc func updateTimer() {
        guard viewModel.isTimerRunning() else {
            resendTimer.invalidate()
            resendButton.setTitle("Отправить", for: .normal)
            resendButton.isEnabled = true
            return
        }
        viewModel.secondsDecrement()
        resendButton.setTitle(viewModel.timeString, for: .normal)
    }
    
    @objc func resendButtonTapped() {
        // api call
        viewModel.resetTimer()
        setupTimer()
        resendButton.setTitle(viewModel.timeString, for: .normal)
    }

    @objc func continueButtonTapped() {
        guard code == "0000" else {
            ProgressHUD.banner("Ошибка", "Неверный код подтверждения", delay: 3)
            return
        }
        onAction?()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let index = codeTextFields.firstIndex(of: textField) else { return }
        if  index < codeTextFields.count - 1 {
            codeTextFields[index + 1].becomeFirstResponder()
        }
        if codeTextFields[index].text == "", index > 0 {
            codeTextFields[index - 1].becomeFirstResponder()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height + 8
            continueButton.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardHeight)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(50)
            }
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        continueButton.snp.remakeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
