//
//  ProfileCardView.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 28/03/2025.
//

import UIKit

private enum Constants {
    static let cornerRadius: CGFloat = 15.0
    static let padding: CGFloat = 15.0
    static let imageHeightMultiplier: CGFloat = 0.5
    static let labelSpacing: CGFloat = 10.0
}

class ProfileCardView: UIView {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let coordinatesLabel = UILabel()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.primaryColor
        setStyle()
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setStyle() {
        self.layer.cornerRadius = Constants.cornerRadius
        self.clipsToBounds = true

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 1
        nameLabel.textColor = UIColor.secondaryColor

        addressLabel.textAlignment = .center
        addressLabel.numberOfLines = 0
        addressLabel.textColor = UIColor.secondaryColor

        coordinatesLabel.textAlignment = .center
        coordinatesLabel.numberOfLines = 0
        coordinatesLabel.textColor = UIColor.secondaryColor
    }

    func setContent(_ content: User) {
        if let url = NSURL(string: content.picture.large) {
            DownloaderImage.download(from: url) { [weak self] success, image in
                DispatchQueue.main.async {
                    self?.imageView.image = success ? image : UIImage(named: "BrokenImageIcon")
                }
            }
        }

        nameLabel.text = "\(content.name.first) \(content.name.last)"
        addressLabel.text = content.location.street.name + ", \(content.location.city), \(content.location.country)"
        coordinatesLabel.text = "Lat: \(content.location.coordinates.latitude), Lon: \(content.location.coordinates.longitude)"
    }

    private func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(coordinatesLabel)
    }

    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        coordinatesLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.imageHeightMultiplier),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.labelSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.labelSpacing),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            
            coordinatesLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: Constants.labelSpacing),
            coordinatesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            coordinatesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            coordinatesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding)
        ])
    }
}
