//
//  DetailViewController.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    private var photoimageView: UIImageView!
    private var labelAuthor: UILabel!
    private var labelLocation: UILabel!
    private var labelDate: UILabel!
    private var labelDownLoads: UILabel!
    private var stackView: UIStackView!
    private var labelStackView: UIStackView!
    private var addToFavouriteButton: UIButton!
    private var scrollView: UIScrollView!
    private var model: Gallery? = nil
    private var bool: Bool = false {
        didSet {
            if !oldValue {
                self.addToFavouriteButton.backgroundColor = .red
                self.addToFavouriteButton.setTitle("Delete from favourite", for: .normal)
            } else {
                self.addToFavouriteButton.backgroundColor = .white
                self.addToFavouriteButton.setTitle("add Favourite", for: .normal)
            }
            
        }
    }
    
    var viewModel: DetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        binding()
    }
    
    private func binding() {
        viewModel?.prepareData()
        viewModel?.box?.bindAndFire(listener: {[weak self] update in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let url = URL(string: (update?.urls.small)!) else { return }
                self.photoimageView.kf.setImage(with: url)
                self.labelAuthor.text = update?.user.name
                if let location = update?.user.location {
                    self.labelLocation.text = location
                } else {
                    self.labelLocation.text = "no data"
                }
                self.labelDate.text = update?.created_at
                guard let downLoads = update?.user.total_collections else { return }
                self.labelDownLoads.text = String(downLoads)
                self.model = update
            }
        })
    }
}

extension DetailViewController {
    private func setUI() {
        title = "Detail"
        addToFavouriteButton = UIButton(title: "Add to Favourite",
                                        titleColor: .black,
                                        backGroundColor: .white,
                                        isShadow: true,
                                        cornerRadus: 10)
        scrollView = UIScrollView(frame: view.bounds)
        photoimageView = UIImageView()
        labelAuthor = UILabel()
        labelLocation = UILabel()
        labelDate = UILabel()
        labelDownLoads = UILabel()
        labelStackView = UIStackView(arrangedSubviews: [
            labelAuthor,
            labelLocation,
            labelDownLoads,
            labelDate
        ],
                                     axis: .vertical,
                                     spacing: 10)
        stackView = UIStackView(arrangedSubviews: [
            photoimageView,
            labelStackView,
            addToFavouriteButton
        ],
                                axis: .vertical,
                                spacing: 30)
        addToFavouriteButton.addAction(UIAction(handler: {_ in
            if !self.bool {
                self.viewModel?.addToFavourite(model: self.model!, flag: !self.bool)
            } else {
                self.viewModel?.delete(name: self.model?.user.name ?? "")
            }
            self.bool = !self.bool
            
        }), for: .touchUpInside)
        photoimageView?.translatesAutoresizingMaskIntoConstraints = false
        labelAuthor?.translatesAutoresizingMaskIntoConstraints = false
        labelLocation?.translatesAutoresizingMaskIntoConstraints = false
        labelDate?.translatesAutoresizingMaskIntoConstraints = false
        labelDownLoads?.translatesAutoresizingMaskIntoConstraints = false
        stackView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        photoimageView.contentMode = .scaleAspectFit
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            photoimageView.widthAnchor.constraint(equalToConstant: stackView.bounds.width),
            photoimageView.heightAnchor.constraint(equalToConstant: 350),
            
            
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        ])
    }
}
