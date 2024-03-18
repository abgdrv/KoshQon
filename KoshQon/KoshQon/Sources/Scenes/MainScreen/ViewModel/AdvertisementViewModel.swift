//
//  AdvertisementViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation

protocol IAdvertisementCellViewModel {
    var title: String { get }
    var address: String { get }
    var date: String { get }
    var rating: String { get }
}

final class AdvertisementViewModel {
    let advertisement: Advertisement
    
    init(advertisement: Advertisement) {
        self.advertisement = advertisement
    }
}

extension AdvertisementViewModel: IAdvertisementCellViewModel {
    var title: String {
        advertisement.title
    }
    
    var address: String {
        advertisement.address
    }
    
    var date: String {
        advertisement.date
    }
    
    var rating: String {
        "\(advertisement.rating)"
    }
}
