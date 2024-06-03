//
//  AnnouncementDetailsFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 02.06.2024.
//

import Foundation

protocol AnnouncementDetailsFlowFactory: AlertFlowFactory, ProfileFlowFactory {
    func makeAnnouncementDetailsView(announcement: Announcement) -> AnnouncementDetailsViewController
}
