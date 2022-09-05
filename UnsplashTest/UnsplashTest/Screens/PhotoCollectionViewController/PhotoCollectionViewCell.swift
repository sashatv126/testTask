//
//  PhotoCollectionViewCell.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {

    let photoImageView = UIImageView()
    private var downloadTask: DownloadTask?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        
        photoImageView.image = nil
        downloadTask?.cancel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Gallery) {
        let url = URL(string: model.urls.small)
        photoImageView.kf.setImage(with: url)
    }

    private func setUI() {
        photoImageView.layer.masksToBounds = true
        layer.masksToBounds = true
        clipsToBounds = true
        self.layer.cornerRadius = 10
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        photoImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }

}
