//
//  MainScreenFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 25.03.2024.
//

import Foundation

protocol MainScreenFlowFactory: AnnouncementsFlowFactory, AnnouncementDetailsFlowFactory {
    func makeMainScreenView(isFirst: Bool) -> MainScreenViewController
}
