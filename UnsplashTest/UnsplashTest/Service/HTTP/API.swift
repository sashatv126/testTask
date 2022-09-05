//
//  ApiService.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import Foundation

protocol Networking {
    func getPhotos<T: Decodable>(type: Path,
                                 completion: @escaping ((Result<T,NetworkError>) -> Void))
}

final class API: Networking {
    private let queue = DispatchQueue.global(qos: .default)
    private let session = URLSession(configuration: .default)
    
    func getPhotos<T: Decodable>(type: Path,
                                 completion: @escaping ((Result<T,NetworkError>) -> Void))
    {
        let request = type.createRequest()
        guard let request = request else { return }
        print(request)
        
            session.dataTask(with: request){ data, response, error  in
                guard let http = response as? HTTPURLResponse,
                http.statusCode == 200 else { return }
                if error != nil {
                    completion(.failure(NetworkError.serverError))
                    return
                }
                do {
                    if let data = data {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(result))
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                    completion(.failure(NetworkError.decodingError))
                }
            }.resume()
    }
}
