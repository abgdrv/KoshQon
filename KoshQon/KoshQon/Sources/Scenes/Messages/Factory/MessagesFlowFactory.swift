//
//  MessagesFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.05.2024.
//

import UIKit

protocol MessagesFlowFactory: AlertFlowFactory {
    func makeMessagesView(isATCChat: Bool) -> UIViewController
}
