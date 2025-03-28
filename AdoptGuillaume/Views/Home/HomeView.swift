//
//  HomeView.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import UIKit

class HomeView: UIView {
    let userViewModel: UserViewModel
    
    let datingGalleryCollectionView: DatingGalleryCollectionView
    
    init(userViewModel: UserViewModel, rootViewController: UIViewController) {
        self.userViewModel = userViewModel
        self.datingGalleryCollectionView = DatingGalleryCollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout(),
            userViewModel: userViewModel,
            rootViewController: rootViewController
        )
        super.init(frame: .zero)
        backgroundColor = UIColor.backgroundColor
        setupBindings()
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBindings() {
        userViewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                guard let self = self else { return }
                datingGalleryCollectionView.dataSourceArray = users
            }
            .store(in: &userViewModel.cancellables)
    }
    
    func setupViews() {
        addSubview(datingGalleryCollectionView)
    }
    
    func setupLayout() {
        datingGalleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datingGalleryCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            datingGalleryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            datingGalleryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            datingGalleryCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
