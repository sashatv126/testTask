//
//  DetailViewModel.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 05.09.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    var box: Box<Gallery?>? { get set }
    func prepareData()
    func addToFavourite(model: Gallery, flag: Bool)
    func delete(name: String)
}

final class DetailViewModel: DetailViewModelProtocol {
    
    
    var box: Box<Gallery?>?
    private var galery: Gallery?
    private let service: CoreDataManager?
    
    
    init(service: CoreDataManager, model: Gallery) {
        self.galery = model
        print(model)
        self.box = Box(nil)
        self.service = service
    }
    
    func prepareData() {
        var created = ""
        let dateFormatter = ISO8601DateFormatter()
        let dateForm = DateFormatter()
        dateForm.dateFormat = "MM.dd.yyyy HH:mm"
        if dateFormatter.date(from: galery!.created_at) != nil {
            let date = dateFormatter.date(from: galery!.created_at)
            guard let date = date else {
                return
            }
            created = dateForm.string(from: date)
        } else {
            created = galery!.created_at
        }
       
        let model = Gallery(id: galery!.id, created_at: created, urls: galery!.urls, user: galery!.user, width: galery!.width, height: galery!.height)
        self.box?.value = model
    }
    
    func addToFavourite(model: Gallery, flag: Bool) {
        let downloads = Int32(model.user.total_collections!)
         try? service?.saveFile(name: model.user.name, data: model.created_at, preview: model.urls.small, location: model.user.location ?? "no data", downloads: downloads, flag: flag)
    }
    
    func delete(name: String) {
        try? service?.delete(name: name)
    }
}
