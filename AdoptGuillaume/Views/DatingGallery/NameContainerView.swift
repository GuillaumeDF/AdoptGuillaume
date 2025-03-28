//
//  NameContainerView.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import UIKit

import UIKit

private enum Constants {
    static let nameLabelPadding: CGFloat = 8
    static let nameLabelVerticalPadding: CGFloat = 5
    static let cornerRadius: CGFloat = 10
    static let fontSize: CGFloat = 14
}

class NameContainerView: UIView {
    private let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(fistname: String, age: Int) {
        nameLabel.text = "\(fistname), \(age)"
    }
    
    func setStyle() {
        self.backgroundColor = UIColor.primaryColor
        self.layer.cornerRadius = Constants.cornerRadius
        self.clipsToBounds = true
        
        nameLabel.textColor = UIColor.primaryTextColor
        nameLabel.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .bold)
        nameLabel.textAlignment = .center
    }
    
    func setupViews() {
        addSubview(nameLabel)
    }
    
    func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.nameLabelPadding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.nameLabelPadding),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.nameLabelVerticalPadding),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.nameLabelVerticalPadding)
        ])
    }
}
