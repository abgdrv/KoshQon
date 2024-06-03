//
//  AnnouncementDetailsViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 02.06.2024.
//

import SwiftUI
import SnapKit

final class AnnouncementDetailsViewController: BaseViewController {
    
    var didProfileTap: Callback<User>?
    
    private let viewModel: AnnouncementDetailsViewModel
    
    private lazy var hostingController = UIHostingController(rootView: AnnouncementDetailsView(viewModel: viewModel))
    private lazy var announcementDetailsView = hostingController.view ?? UIView()
    
    init(viewModel: AnnouncementDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBindings()
    }
}

private extension AnnouncementDetailsViewController {
    func setupViews() {
        view.addSubview(announcementDetailsView)
    }
    
    func setupConstraints() {
        announcementDetailsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupBindings() {
        viewModel.didProfileTap = { [weak self] user in
            guard let self = self else { return }
            self.didProfileTap?(user)
        }
    }
}
