//
//  FavouriteViewController.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import UIKit

final class FavouriteViewController: UIViewController {
    private var collectionView: UICollectionView!
    var viewModel: FavouriteViewModelProtocol?
    var router: FavouriteRouterProtocol?
    
    private var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel?.getData()
        viewModel?.box?.bindAndFire(listener: {[weak self] update in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.photos = update
                self.collectionView.reloadData()
            }
        })
    }
}

extension FavouriteViewController {
    private func setUI() {
        title = "Favourite"
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.addSubview(collectionView)
        FavouritePhotoCell.registerWithoutNib(for: collectionView)
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
}

//MARK: -UICollectionViewDataSource

extension FavouriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = FavouritePhotoCell.dequeue(collectionView, for: indexPath)
        cell.configure(model: photos[indexPath.row])
        return cell
    }
}

//MARK: -UICollectionViewDelegate

extension FavouriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = photos[indexPath.row]
        let item = viewModel?.prepare(model: model)
        router?.route(model: item!)
    }
}

//MARK: -UICollectionViewDelegateFlowLayout

extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 100)
    }
}
