//
//  UIView+Extension.swift
//  popo
//
//  Created by 초이 on 2021/05/20.
//

import UIKit

extension UIView {
    func makeRounded(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    func makeRoundedWithBorder(radius: CGFloat, color: CGColor) {
        makeRounded(radius: radius)
        self.layer.borderWidth = 1
        self.layer.borderColor = color
    }
}
