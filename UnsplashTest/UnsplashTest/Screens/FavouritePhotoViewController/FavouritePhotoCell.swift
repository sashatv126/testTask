//
//  FavouritePhotoCell.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import UIKit

class FavouritePhotoCell: UICollectionViewCell {

    let photoImageView = UIImageView()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        
        photoImageView.image = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Photo) {
        let url = URL(string: model.url!)
        photoImageView.kf.setImage(with: url)
        label.text = model.author
    }

    private func setUI() {
        photoImageView.layer.masksToBounds = true
        layer.masksToBounds = true
        clipsToBounds = true
        self.layer.cornerRadius = 10
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 2 - 30),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

}
