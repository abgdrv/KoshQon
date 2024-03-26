//
//  AddAnnouncementFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation

protocol AddAnnouncementFlowFactory: AlertFlowFactory {
    func makeAddAnnouncementView() -> AddAnnouncementViewController
}
