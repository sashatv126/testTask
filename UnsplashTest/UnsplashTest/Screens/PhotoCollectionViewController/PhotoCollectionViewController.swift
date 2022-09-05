//
//  ViewController.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import UIKit
import PhotosUI

final class PhotoCollectionViewController: UIViewController {
    //MARK: -Public Properties
    
    private var photos = [Gallery]()
    var router: CollectionRouterProtocol?
    var viewModel: PhotoViewModelLogic?
    
    //MARK: -Private Properties
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        getData()
        setSearchController()
    }
    
    //MARK: -Private Methods
    
    private func getData() {
        viewModel?.getData(type: .random, completion: {[weak self] error in
            guard let self = self else {return}
            if error == nil {
                self.bindViewModel()
            }
        })
    }
    
    private func findData(text: String) {
        viewModel?.findData(type: .find(query: text), completion: {[weak self] error in
            guard let self = self else {return}
            if error == nil {
                self.bindViewModel()
            }
        })
    }
    
    private func bindViewModel() {
        viewModel?.box?.bind(listener: {[weak self] update in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.photos = update
                self.collectionView.reloadData()
            }
        })
    }
}

//MARK: -SetUI

extension PhotoCollectionViewController {
    private func setUI() {
        title = "Photos"
        let layout = WaterfallLayout(with: self)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.addSubview(collectionView)
        PhotoCollectionViewCell.registerWithoutNib(for: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setSearchController() {
        let search = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = false
        search.hidesNavigationBarDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        navigationItem.searchController = search
    }
    
    func configureContextMenu(indexPath: IndexPath) -> UIContextMenuConfiguration{
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let save = UIAction(title: "Save",
                                identifier: nil,
                                discoverabilityTitle: nil,
                                state: .off)
            {[weak self] (_) in
                guard let self = self else { return }
                let temp = self.collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
                let tempImage = temp.photoImageView.image
                let status = PHPhotoLibrary.authorizationStatus()
                guard status == .authorized else { return }
                if let tempImage = tempImage {
                    self.viewModel?.saveImageForLibrary(image: tempImage)
                }
            }
            
            return UIMenu(title: "",
                          image: nil,
                          children: [save])
        }
        return context
    }
}

//MARK: -UICollectionViewDataSource

extension PhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PhotoCollectionViewCell.dequeue(collectionView, for: indexPath)
        let model = photos[indexPath.row]
        cell.configure(model: model)
        return cell
    }
}

//MARK: -UICollectionViewDelegate

extension PhotoCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        configureContextMenu(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = photos[indexPath.row]
        router?.route(model: model)
    }
}

extension PhotoCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        findData(text: searchBar.text ?? "")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getData()
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}

//MARK: -UICollectionViewDelegateFlowLayout

extension PhotoCollectionViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let photo = photos[safe: indexPath.item] else { return .zero }
        
        return CGSize(width: CGFloat(photo.width), height:  CGFloat(photo.height))
    }
}

