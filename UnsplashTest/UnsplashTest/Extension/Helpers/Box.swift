//
//  Box.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

class Box<T> {
typealias Listener = (T) -> Void
var listener: Listener?

func bind(listener: Listener?) {
    self.listener = listener
}

func bindAndFire(listener: Listener?) {
    self.listener = listener
    listener?(value)
}

var value: T {
    didSet {
        listener?(value)
    }
}

init(_ v: T) {
    value = v
}}
