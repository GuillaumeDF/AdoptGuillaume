//
//  ProfileDetailViewController.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import UIKit

private enum Constants {
    static let cardMargin: CGFloat = 15
    static let topMargin: CGFloat = 20
    static let bottomMargin: CGFloat = -20
    static let cardPadding: CGFloat = 15
    static let cornerRadius: CGFloat = 15
}

class ProfileDetailViewController: UIViewController {
    private let cardView = ProfileCardView()

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        setContent(user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        setStyle()
        setupViews()
        setupLayout()
    }
    
    func setStyle() {
        cardView.layer.cornerRadius = Constants.cornerRadius
        cardView.layer.masksToBounds = true
        cardView.backgroundColor = UIColor.primaryColor
    }
    
    func setContent(_ content: User) {
        cardView.setContent(content)
    }
    
    func setupViews() {
        view.addSubview(cardView)
    }
    
    func setupLayout() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.cardMargin),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.cardMargin),
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topMargin),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.bottomMargin)
        ])
    }
}
