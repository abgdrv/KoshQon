//
//  ImageSettable.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 07.04.2024.
//

import Foundation
import UIKit
import RSKImageCropper

protocol ImageSettable {
    var image: UIImage? { get }
    var didFinish: VoidCallback? { get set }
    var didImagePickerOptionsShow: PairCallback<UIImagePickerController, Bool>? { get set }
    var didCropCancel: VoidCallback? { get set }
    var didImageCrop: VoidCallback? { get set }
    var didCropImageShow: Callback<RSKImageCropViewController>? { get set }
    var didImageDelete: VoidCallback? { get set }
}
