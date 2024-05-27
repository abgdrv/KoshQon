//
//  MessagessViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.05.2024.
//

import UIKit
import SnapKit

final class MessagessViewController: BaseViewController {
    
    override var navigationTitleType: NavigationTitleType {
        return .messages
    }
    
    private lazy var contentView = UIView().apply {
        $0.backgroundColor = AppColor.Theme.secondaryBackground.uiColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
