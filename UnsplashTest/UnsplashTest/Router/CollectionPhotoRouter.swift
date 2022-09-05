//
//  CollectionPhotoRouter.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import Foundation

protocol CollectionRouterProtocol {
    func route(model: Gallery)
}

class CollectionRouter {
    // MARK: - Public Properties
    weak var viewController: PhotoCollectionViewController?
}

// MARK: - Routing Logic
extension CollectionRouter: CollectionRouterProtocol {
    func route(model: Gallery) {
        let vc = Builder.buildDetailViewController(model: model)
        viewController!.navigationController!.pushViewController(vc, animated: true)
    }
}
