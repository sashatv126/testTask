//
//  Builder.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import Foundation

struct Builder {
    //create screens
    static func buildPhotoViewController() -> PhotoCollectionViewController {
        let viewController = PhotoCollectionViewController()
        Builder.createPhotoView(viewController: viewController)
        return viewController
    }
    
    static func buildFavouriteViewController() -> FavouriteViewController {
        let viewController = FavouriteViewController()
        Builder.createFavouriteView(viewController: viewController)
        return viewController
    }
    
    static func buildDetailViewController(model: Gallery) -> DetailViewController {
        let viewController = DetailViewController()
        Builder.createDetailView(viewController: viewController, model: model)
        return viewController
    }
}

extension Builder {
    //configure screens
    private static func createPhotoView(viewController: PhotoCollectionViewController) {
        let router = CollectionRouter()
        router.viewController = viewController
        let service = API()
        let viewModel = PhotoViewModel(service: service)
        viewController.router = router
        viewController.viewModel = viewModel
    }
    
    private static func createFavouriteView(viewController: FavouriteViewController) {
        let coreData = CoreDataBase()
        let viewModel = FavouriteViewModel(service: coreData)
        let router = FavouriteRouter()
        viewController.viewModel = viewModel
        viewController.router = router
        router.viewController = viewController
    }
    
    private static func createDetailView(viewController: DetailViewController, model: Gallery) {
        let coreData = CoreDataBase()
        let viewModel = DetailViewModel(service: coreData, model: model)
        viewController.viewModel = viewModel
    }
}
