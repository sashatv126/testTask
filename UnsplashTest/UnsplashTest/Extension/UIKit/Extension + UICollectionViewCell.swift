//
//  Extension + UICollectionViewCell.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import UIKit

extension UICollectionViewCell {
    //Extension for UICollectionViewCell to simplify register cells
    
    fileprivate class var stringName: String {
        return String(describing: self.self)
    }
    
    class var reuseID: String {
        return stringName
    }
    
    class func registerWithoutNib(`for` collectionView: UICollectionView) {
        collectionView.register(self.self, forCellWithReuseIdentifier: self.reuseID)
    }

    class func dequeue(_ collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        return unsafeDowncast(collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseID, for: indexPath), to: self)
    }
}
