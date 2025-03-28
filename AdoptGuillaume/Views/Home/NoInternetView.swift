//
//  NoInternetView.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 28/03/2025.
//

import UIKit

private enum Constants {
    static let errorMessage: String = "No internet connection. Please check your network settings."
    static let cornerRadius: CGFloat = 10
    static let padding: CGFloat = 16
}

class NoInternetView: UIView {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        
        label.text = Constants.errorMessage
        label.textColor = UIColor.primaryTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding)
        ])
    }
}
