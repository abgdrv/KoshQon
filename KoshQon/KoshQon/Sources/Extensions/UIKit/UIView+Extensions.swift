//
//  UIView+Extensions.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.03.2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
}

extension UIView {
    
    private var bezierPathIdentifier: String {
        return "bezierPathBorderLayer"
    }
    
    private var bezierPathBorder: CAShapeLayer? {
        return (self.layer.sublayers?.filter({ (layer) -> Bool in
            return layer.name == self.bezierPathIdentifier && (layer as? CAShapeLayer) != nil
        }) as? [CAShapeLayer])?.first
    }
    
    func bezierPathBorder(color: UIColor, width: CGFloat = 1) {
        var border = self.bezierPathBorder
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
        if border == nil {
            border = CAShapeLayer()
            border!.name = self.bezierPathIdentifier
            self.layer.addSublayer(border!)
        }
        
        border!.frame = self.bounds
        let pathUsingCorrectInsetIfAny = UIBezierPath(roundedRect: border!.bounds,
                                                      cornerRadius:self.layer.cornerRadius)
        
        border!.path = pathUsingCorrectInsetIfAny.cgPath
        border!.fillColor = UIColor.clear.cgColor
        border!.strokeColor = color.cgColor
        border!.lineWidth = width * 2
    }
    
    func removeBezierPathBorder() {
        self.layer.mask = nil
        self.bezierPathBorder?.removeFromSuperlayer()
    }
}
