//
//  Extension  + Array.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
