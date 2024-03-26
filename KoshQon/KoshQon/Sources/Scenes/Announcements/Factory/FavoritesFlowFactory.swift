//
//  FavoritesFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation

protocol FavoritesFlowFactory: AlertFlowFactory {
    func makeFavoritesView(type: AnnouncementsType) -> AnnouncementsViewController
}
