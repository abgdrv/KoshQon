//
//  FriendsFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 10.04.2024.
//

import Foundation

protocol FriendsFlowFactory: ProfileFlowFactory {
    func makeFriendsView() -> FriendsViewController
    func makeBottomSheetView() -> BottomSheetViewController
}
