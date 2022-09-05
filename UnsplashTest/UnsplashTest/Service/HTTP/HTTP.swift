//
//  HTTP.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import Foundation

enum Methods: String {
    case get = "GET"
}

enum NetworkError: Error {
    case serverError
    case decodingError
}

enum Path {
    case find(query: String)
    case random
    
    var path: String {
        return "https://api.unsplash.com/"
    }
    
    var enpoint: String {
        switch self {
        case .find:
            return "search/photos"
        case .random:
            return "photos"
        }
    }
}

extension Path {
    func createRequest() -> URLRequest? {
        let fullPath = path + enpoint
        var components = URLComponents(string: fullPath)
        var queryItems = [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "per_page", value: "30")
            ]
        switch self {
        case .find(let query):
            queryItems.append(URLQueryItem(name: "query", value: query))
        case .random:
            queryItems.append(URLQueryItem(name: "order_by", value: "latest"))
        }
        components?.queryItems = queryItems
        guard let url = components?.url else { return nil}
        var request = URLRequest(url: url)
        request.httpMethod = Methods.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Client-ID \(Keys.key)", forHTTPHeaderField: "Authorization")
        return request
    }
}
