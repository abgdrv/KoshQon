//
//  FriendsViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 10.04.2024.
//

import Foundation

final class FriendsViewModel {
    
    // MARK: - Properties
    
    private(set) var friendCellViewModels: [FriendCellViewModel] = []
    
    private let friends: [Friend] = [
        .init(id: 0, imageUrl: "", firstName: "Almat", lastName: "Begaidarov", country: .kz, city: .kostanay),
        .init(id: 0, imageUrl: "", firstName: "Almat", lastName: "Begaidarov", country: .kz, city: .kostanay),
        .init(id: 0, imageUrl: "", firstName: "Almat", lastName: "Begaidarov", country: .kz, city: .kostanay),
        .init(id: 0, imageUrl: "", firstName: "Almat", lastName: "Begaidarov", country: .kz, city: .kostanay),
        .init(id: 0, imageUrl: "", firstName: "Almat", lastName: "Begaidarov", country: .kz, city: .kostanay),
        .init(id: 0, imageUrl: "", firstName: "Almat", lastName: "Begaidarov", country: .kz, city: .kostanay),
        .init(id: 0, imageUrl: "", firstName: "Almat", lastName: "Begaidarov", country: .kz, city: .kostanay),
    ]
    
    // MARK: - Object Lifecycle
    
    init() {
        getFriends()
    }
    
    // MARK: - Private methods
    
    private func makeFriendCellViewModels(items: [Friend]) -> [FriendCellViewModel] {
        return items.compactMap { FriendCellViewModel(friend: $0) }
    }
}

// MARK: - Request

private extension FriendsViewModel {
    func getFriends() {
        friendCellViewModels = makeFriendCellViewModels(items: friends)
    }
}

