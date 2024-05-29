//
//  SmsCodeView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.02.2024.
//

import UIKit
import SnapKit

final class SmsCodeView: BaseView {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    
    private let viewModel: SmsCodeViewModel
    private var codeTextFields: [UITextField] = []
    
    override var keyboardHandlingButton: ProceedButton? {
        return continueButton
    }
    
    private var resendTimer = Timer()
    
    private var code: String {
        var code = ""
        codeTextFields.forEach { code += $0.text ?? "" }
        return code
    }
    
    // MARK: - UI
    
    private lazy var infoLabel = InfoLabel(type: .sms)
    
    private lazy var phoneNumberLabel = UILabel().apply {
        $0.text = "+7 (777) 777 77 77"
        $0.set(font: AppFont.medium.s20, textColor: AppColor.Theme.mainTitle.uiColor)
    }
    
    private lazy var codeStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
        for _ in 0..<4 {
            let textField = InputTextField(inputType: .sms)
            textField.delegate = self
            $0.addArrangedSubview(textField)
            codeTextFields.append(textField)
        }
        codeTextFields[0].becomeFirstResponder()
    }
    
    private lazy var resendLabel = InfoLabel(type: .resend)
    
    private lazy var resendButton = UIButton(type: .system).apply {
        $0.setTitle(viewModel.timeString, for: .normal)
        $0.set(font: AppFont.medium.s16, titleColor: AppColor.Static.darkBlue.uiColor)
        $0.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
    }
    
    private lazy var continueButton = ProceedButton(type: .system).apply {
        $0.type = .continue
        $0.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SmsCodeViewModel) {
        self.viewModel = viewModel
        super.init()
        setupViews()
        setupConstraints()
        setupTimer()
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
        addSubviews(infoLabel, phoneNumberLabel, codeStackView, resendLabel, resendButton, continueButton)
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
            make.height.equalTo(70)
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
}

extension SmsCodeView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let index = codeTextFields.firstIndex(of: textField) else { return false }
        let maxLength = 1
        let currentText = textField.text ?? ""
        var newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count > maxLength {
            newText = String(newText.prefix(maxLength))
        }
        
        if newText.count == maxLength {
            if index + 1 <= 3 {
                codeTextFields[index + 1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        } else if newText.isEmpty {
            if index - 1 >= 0 {
                codeTextFields[index - 1].becomeFirstResponder()
            }
        }
        
        textField.text = newText
        return false
    }
}

// MARK: - Actions

private extension SmsCodeView {
    @objc func updateTimer() {
        guard viewModel.isTimerRunning() else {
            resendTimer.invalidate()
            UIView.transition(with: resendButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.resendButton.setTitle("Отправить", for: .normal)
                self.resendButton.isEnabled = true
            }, completion: nil)
            return
        }
        viewModel.secondsDecrement()
        UIView.transition(with: resendButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.resendButton.setTitle(self.viewModel.timeString, for: .normal)
        }, completion: nil)
    }

    
    @objc func resendButtonTapped() {
        // api call
        for index in codeTextFields.indices {
            codeTextFields[index].text = ""
        }
        viewModel.resetTimer()
        setupTimer()
        resendButton.setTitle(viewModel.timeString, for: .normal)
    }
    
    @objc func continueButtonTapped() {
        guard code == "0000" else {
            return
        }
        didFinish?()
    }
}
