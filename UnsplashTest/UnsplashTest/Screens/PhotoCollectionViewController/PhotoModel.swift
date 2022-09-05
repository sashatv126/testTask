//
//  PhotoModel.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import Foundation

class GalleryModel: Codable {
    let total: Int
    let total_pages: Int
    let results: [Gallery]
}

struct Gallery: Codable {
    let id: String
    let created_at: String
    let urls: URLS
    let user: User
    let width: Int
    let height: Int
}

struct URLS: Codable {
    let small: String
}

struct User: Codable {
    let name: String
    let location: String?
    let total_collections: Int?
}
