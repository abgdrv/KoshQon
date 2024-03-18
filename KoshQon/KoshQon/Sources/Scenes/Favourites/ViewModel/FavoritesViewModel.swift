//
//  FavoritesViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation

final class FavoritesViewModel {
    
    // MARK: - Properties
    
    var items: [AdvertisementViewModel] = []
    
    let ads = [
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7)
    ]
    
    // MARK: - Object Lifecycle
    
    init() {
        getAdvertisements()
    }
    
    // MARK: - Private methods
    
    func makeCellViewModels(items: [Advertisement]) -> [AdvertisementViewModel] {
        return items.compactMap { AdvertisementViewModel(advertisement: $0) }
    }
}

// MARK: - Request

private extension FavoritesViewModel {
    func getAdvertisements() {
        items = makeCellViewModels(items: ads)
    }
}
