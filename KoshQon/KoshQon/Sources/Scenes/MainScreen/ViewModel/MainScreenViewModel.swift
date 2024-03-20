//
//  MainScreenViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation

final class MainScreenViewModel {
    
    // MARK: - Properties
    
    var adViewModels: [AdvertisementViewModel] = []
    var navigationItemViewModels: [MainNavigationCellViewModel] = []
    
    let navigationItems = MainNavigationType.allCases
    let ads = [
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7)
    ]
    
    // MARK: - Object Lifecycle
    
    init() {
        getAdvertisements()
        getNavigationItems()
    }
    
    // MARK: - Private methods
    
    private func makeAdvertisementCellViewModels(items: [Advertisement]) -> [AdvertisementViewModel] {
        return items.compactMap { AdvertisementViewModel(advertisement: $0) }
    }
    
    private func makeNavigationCellViewModels(items: [MainNavigationType]) -> [MainNavigationCellViewModel] {
        return items.compactMap { MainNavigationCellViewModel(type: $0) }
    }
}

// MARK: - Request

private extension MainScreenViewModel {
    func getAdvertisements() {
        adViewModels = makeAdvertisementCellViewModels(items: ads)
    }
    
    func getNavigationItems() {
        navigationItemViewModels = makeNavigationCellViewModels(items: navigationItems)
    }
}
