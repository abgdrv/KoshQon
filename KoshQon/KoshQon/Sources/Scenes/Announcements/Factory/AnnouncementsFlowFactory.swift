//
//  FavoritesFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation

protocol AnnouncementsFlowFactory: AlertFlowFactory {
    func makeAnnouncementsView(type: AnnouncementsType) -> AnnouncementsViewController
}
