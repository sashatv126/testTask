//
//  Extension + UIButton.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 05.09.2022.
//

import UIKit

extension UIButton {
    convenience init(title : String?,
                         titleColor : UIColor,
                         backGroundColor : UIColor,
                         fornt : UIFont? = .systemFont(ofSize: 20),
                         isShadow : Bool = false,
                         cornerRadus : CGFloat = 30) {
            self.init(type : .system)
            self.setTitle(title, for: .normal)
            self.setTitleColor(titleColor, for: .normal)
            self.backgroundColor = backGroundColor
            self.titleLabel?.font = fornt
            self.layer.cornerRadius = cornerRadus
            if isShadow {
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowRadius = 4
                self.layer.shadowOpacity = 0.5
                self.layer.shadowOffset = CGSize(width: 0, height: 4)
            }
        }
}
