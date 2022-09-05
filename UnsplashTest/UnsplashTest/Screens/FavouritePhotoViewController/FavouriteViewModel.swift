//
//  FavouriteViewModel.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 05.09.2022.
//

protocol FavouriteViewModelProtocol {
    var box: Box<[Photo]>? { get set }
    func getData()
    func prepare(model: Photo) -> Gallery
}

final class FavouriteViewModel: FavouriteViewModelProtocol {
    
    var box: Box<[Photo]>?
    private let service: CoreDataManager?
    
    
    init(service: CoreDataManager) {
        self.box = Box([])
        self.service = service
    }
    
    func getData() {
        self.box?.value = service?.getData() ?? []
    }
    
    func prepare(model: Photo) -> Gallery {
        let downloads = Int(model.downloads)
        return Gallery(id: "", created_at: model.created!, urls: URLS(small: model.url!), user: User(name: model.author!, location: model.location, total_collections: downloads), width: 0, height: 0)
    }
}
