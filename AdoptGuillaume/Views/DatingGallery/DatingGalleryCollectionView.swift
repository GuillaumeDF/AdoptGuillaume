//
//  DatingGalleryCollectionView.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import UIKit

private enum Constants {
    static let cellHeight: CGFloat = 200
}

class DatingGalleryCollectionView: UICollectionView {
    private var rootViewController: UIViewController
    private var userViewModel: UserViewModel
    
    var dataSourceArray: [User] = [] {
        didSet {
            reloadData()
        }
    }
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, userViewModel: UserViewModel, rootViewController: UIViewController) {
        self.userViewModel = userViewModel
        self.rootViewController = rootViewController
        super.init(frame: frame, collectionViewLayout: layout)
        register(DatingGalleryCell.self, forCellWithReuseIdentifier: DatingGalleryCell.reuseIdentifier)
        backgroundColor = UIColor.backgroundColor
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DatingGalleryCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.row == lastIndex {
            userViewModel.fetchNextUsers()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSourceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DatingGalleryCell.reuseIdentifier, for: indexPath) as? DatingGalleryCell else {
            return UICollectionViewCell()
        }

        cell.setContent(dataSourceArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = dataSourceArray[indexPath.row]
        let controller = ProfileDetailViewController(user: selectedUser)
        
        guard let navigationController = self.rootViewController.navigationController else { return }
        navigationController.pushViewController(controller, animated: true)
    }
}

extension DatingGalleryCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let externalInsets = collectionView.layoutMargins
        let availableWidth = collectionView.frame.width - externalInsets.left - externalInsets.right
        let cellWidth = (availableWidth - 5) / 2
        
        return CGSize(width: cellWidth, height: Constants.cellHeight)
    }
}
