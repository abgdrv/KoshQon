//
//  DatePicker.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.04.2024.
//

import UIKit

final class DatePicker: UIDatePicker {
    
    // MARK: - Properties
    
    var didDateChange: Callback<String>?
    
    var selectedDate: String {
        return date.toString(format: format)
    }
    
    private let format: String
    
    // MARK: - Object Lifecycle

    init(format: String) {
        self.format = format
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension DatePicker {
    func setup() {
        datePickerMode = .date
        preferredDatePickerStyle = .wheels
        backgroundColor = AppColor.Theme.blockBackground.uiColor
        addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        locale = UserDefaultsService.shared.language.locale
        
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        components.year = -18
        components.month = 0
        let maxDate = calendar.date(byAdding: components, to: currentDate)
        
        components.year = -94
        let minDate = calendar.date(byAdding: components, to: currentDate)
        
        maximumDate = maxDate
        minimumDate = minDate
    }
}

// MARK: - Actions

private extension DatePicker {
    @objc func datePickerValueChanged() {
        didDateChange?(selectedDate)
    }
}
