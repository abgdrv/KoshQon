//
//  FriendsViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 09.04.2024.
//

import UIKit
import SnapKit

final class FriendsViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didFriendCellTap: Callback<Int>?
    
    private let viewModel: FriendsViewModel
    
    override var navigationTitleType: NavigationTitleType? {
        return .friends
    }
    
    // MARK: - UI
    
    private lazy var friendsTableView = UITableView(frame: .zero, style: .plain).apply {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.register(type: FriendCell.self)
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friendCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FriendCell(viewModel: viewModel.friendCellViewModels[indexPath.row])
        cell.didFriendCellTap = { [weak self] id in
            guard let self = self else { return }
            self.didFriendCellTap?(id)
        }
        cell.didMoreButtonTap = { [weak self] id in
            guard let self = self else { return }
        }
        return cell
    }
}

// MARK: - Setup Views

private extension FriendsViewController {
    func setupViews() {
        view.addSubview(friendsTableView)
    }
    
    func setupConstraints() {
        friendsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
