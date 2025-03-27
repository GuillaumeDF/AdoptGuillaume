//
//  HomeViewController.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    var userApi = UserApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        testUserApi()
    }
    
    func testUserApi() {
        Task {
            do {
                
                let users = try await userApi.searchUsers()

                for user in users {
                    print("Nom: \(user.name.first) \(user.name.last), Pays: \(user.location.country)")
                }
                
            } catch {
                print("Erreur: \(error.localizedDescription)")
            }
        }
    }
}
