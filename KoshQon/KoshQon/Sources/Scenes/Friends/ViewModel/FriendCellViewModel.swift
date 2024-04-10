//
//  FriendCellViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 10.04.2024.
//

import Foundation
import UIKit

protocol IFriendCellViewModel {
    var image: UIImage? { get }
    var firstName: String { get }
    var lastName: String { get }
    var country: String { get }
    var city: String { get }
}

final class FriendCellViewModel {
    
    // MARK: - Properties
    
    let friend: Friend
    
    // MARK: - Object Lifecycle
    
    init(friend: Friend) {
        self.friend = friend
    }
}

extension FriendCellViewModel: IFriendCellViewModel {
    var image: UIImage? {
        return nil
    }
    
    var firstName: String {
        return friend.firstName
    }
    
    var lastName: String {
        return friend.lastName
    }
    
    var country: String {
        return friend.country.title
    }
    
    var city: String {
        return friend.city.name
    }
}
