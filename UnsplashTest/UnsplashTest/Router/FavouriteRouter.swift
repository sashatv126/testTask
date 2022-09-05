//
//  FavouriteRouter.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 05.09.2022.
//

protocol FavouriteRouterProtocol {
    func route(model: Gallery)
}

class FavouriteRouter {
    // MARK: - Public Properties
    weak var viewController: FavouriteViewController?
}

// MARK: - Routing Logic
extension FavouriteRouter: FavouriteRouterProtocol {
    func route(model: Gallery) {
        let vc = Builder.buildDetailViewController(model: model)
        viewController!.navigationController!.pushViewController(vc, animated: true)
    }
}
