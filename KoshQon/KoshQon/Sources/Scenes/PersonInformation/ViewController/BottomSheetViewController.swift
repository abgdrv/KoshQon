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
    
    private let options: [BottomSheetOption]
    private let isLong: Bool
    private var selectedDayIndexPath: IndexPath?
    
    // MARK: - UI
    
    private lazy var optionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = Constants.PanModal.short / 2
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(BottomSheetCell.self)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Object Lifecycle
    
    init(options: [BottomSheetOption], isLong: Bool) {
        self.options = options
        self.isLong = isLong
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        view.addSubviews(optionsTableView)
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
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(BottomSheetCell.self, indexPath: indexPath)
        cell.configure(option: options[indexPath.row])
        cell.accessoryType = indexPath == selectedDayIndexPath ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedDayIndexPath = indexPath
        tableView.reloadData()
        dismiss(animated: true)
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
