//
//  PhotoViewModel.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import Foundation
import UIKit

protocol PhotoViewModelLogic {
    var box: Box<[Gallery]>? { get set }
    
    func getData(type: Path ,completion: @escaping ((NetworkError?) -> Void))
    func findData(type: Path, completion: @escaping ((NetworkError?) -> Void))
    func saveImageForLibrary(image: UIImage)
}

final class PhotoViewModel: PhotoViewModelLogic {
    
    var box: Box<[Gallery]>?
    private let service: Networking?
    
    init(service: Networking?) {
        self.service = service
        self.box = Box([])
    }
    
    //get data from api
    func getData(type: Path,completion: @escaping ((NetworkError?) -> Void)) {
        service?.getPhotos(type: type, completion: {[weak self] (result: Result<[Gallery],NetworkError>) -> Void in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completion(nil)
                    self.box?.value = data
                    
                case.failure(let error):
                    completion(error)
                }
            }
        })
    }
    
    func findData(type: Path, completion: @escaping ((NetworkError?) -> Void)) {
        service?.getPhotos(type: type, completion: {[weak self] (result: Result<GalleryModel,NetworkError>) -> Void in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completion(nil)
                    self.box?.value = data.results
                    
                case.failure(let error):
                    completion(error)
                }
            }
        })
    }
    
    func saveImageForLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
        
    
