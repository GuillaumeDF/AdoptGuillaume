//
//  HomeViewController.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    var userViewModel: UserViewModel
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        userViewModel.$status
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self = self else { return }
                switch status {
                case .failed:
                    self.view = NoInternetView()
                case .success:
                    let homeView = HomeView(userViewModel: userViewModel, rootViewController: self)
                    self.view = homeView
                default:
                    self.view = UIView()
                }
            }
            .store(in: &subscriptions)
    }
}
