//
//  DatingGalleryCell.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import UIKit

private enum Constants {
    static let cornerRadius: CGFloat = 15
    static let nameContainerHeight: CGFloat = 30
    static let nameContainerPadding: CGFloat = 8
    static let nameContainerMinWidth: CGFloat = 80
}

class DatingGalleryCell: UICollectionViewCell {
    static let reuseIdentifier = "DatingGalleryCell"
    
    private let imageCache = NSCache<NSURL, UIImage>()
    private let imageView = UIImageView()
    private let nameContainerView = NameContainerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(_ content: User) {
        if let url = NSURL(string: content.picture.large) {
            DownloaderImage.download(from: url) { [weak self] success, image in
                DispatchQueue.main.async {
                    self?.imageView.image = success ? image : UIImage(named: "BrokenImageIcon")
                }
            }
        }
        
        nameContainerView.setContent(fistname: content.name.first, age: content.dob.age)
    }
    
    func setStyle() {
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameContainerView)
    }
    
    func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.nameContainerPadding),
            nameContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.nameContainerPadding),
            nameContainerView.heightAnchor.constraint(equalToConstant: Constants.nameContainerHeight),
            nameContainerView.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.nameContainerMinWidth)
        ])
    }
}
