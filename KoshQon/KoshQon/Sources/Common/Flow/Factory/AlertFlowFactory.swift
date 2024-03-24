//
//  AlertFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 24.03.2024.
//

import Foundation
import UIKit

protocol AlertFlowFactory {
    func makeAlert(title: String, message: String, with actions: [UIAlertAction]) -> UIAlertController
    func makeAlertSheet(title: String, message: String, with actions: [UIAlertAction]) -> UIAlertController
}
