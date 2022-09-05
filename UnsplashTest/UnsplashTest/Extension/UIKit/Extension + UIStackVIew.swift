//
//  Extension + UIStackVIew.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import UIKit

extension UIStackView {
    convenience init (arrangedSubviews : [UIView], axis : NSLayoutConstraint.Axis, spacing : CGFloat) {
        self.init(arrangedSubviews : arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}
