//
//  ImageSetFlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 07.04.2024.
//

import Foundation
import UIKit

protocol ImageSetFlowFactory: AlertFlowFactory {
    func makeImageZoomView(image: UIImage?) -> ImageDetailViewController
}
