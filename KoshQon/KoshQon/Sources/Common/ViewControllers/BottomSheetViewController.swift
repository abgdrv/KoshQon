//
//  BottomSheetViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit
import SnapKit
import PanModal

final class BottomSheetViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let isLong: Bool
    
    // MARK: - UI
    
    private lazy var optionsTableView = UITableView(frame: .zero, style: .plain).apply {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.register(type: NavigationCell.self)
    }
    
    // MARK: - Object Lifecycle
    
    init(isLong: Bool) {
        self.isLong = isLong
        super.init()
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup Views

private extension BottomSheetViewController {
    func setupViews() {
        view.addSubview(optionsTableView)
    }
    
    func setupConstraints() {
        optionsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - PanModalPresentable

extension BottomSheetViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
    
    var shortFormHeight: PanModalHeight {
        .contentHeight(isLong ? Constants.PanModal.long : Constants.PanModal.short)
    }
    
    var longFormHeight: PanModalHeight {
        .contentHeight(isLong ? Constants.PanModal.long : Constants.PanModal.short)
    }
    
    var cornerRadius: CGFloat {
        Constants.PanModal.cornerRadius
    }
}
