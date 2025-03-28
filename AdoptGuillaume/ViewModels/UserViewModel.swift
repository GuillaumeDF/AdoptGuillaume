//
//  UserViewModel.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import Foundation
import Combine

private enum Constants {
    static let nationalityToSort: String = "FR"
    static let numberOfUsersToFetch: Int = 50
    static let nationalityToFetch: [String] = ["fr", "us", "gb", "de", "es"]
}

@MainActor
final class UserViewModel {
    enum Status {
        case start
        case inProgress
        case success
        case failed
    }
    
    @Published var status: Status = .start
    @Published var users: [User] = []
    
    private let repository: AdoptRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(repository: AdoptRepositoryProtocol) {
        self.repository = repository
        initFetchUsers()
    }
    
    func initFetchUsers(nationality: String = Constants.nationalityToSort) {
        self.status = .inProgress
        
        Task {
            do {
                let newUsers = try await repository.fetchApiUser(
                    numberOfUsers: Constants.numberOfUsersToFetch,
                    nationalities: Constants.nationalityToFetch
                )
                let frenchUsers = newUsers.filter { $0.nat == nationality }
                
                repository.saveCoreDataUsers(users: frenchUsers)
                
                self.users.append(contentsOf: frenchUsers)
                self.status = .success
            } catch {
                NSLog("Error fetching users: \(error.localizedDescription)")
                if let savedUsers = repository.fetchCoreData() {
                    self.users.append(contentsOf: savedUsers)
                    self.status = self.users.isEmpty ? .failed : .success
                }
            }
        }
    }
    
    func fetchNextUsers(nationality: String = Constants.nationalityToSort) {
        Task {
            do {
                let newUsers = try await repository.fetchApiUser(
                    numberOfUsers: Constants.numberOfUsersToFetch,
                    nationalities: Constants.nationalityToFetch
                )
                let frenchUsers = newUsers.filter { $0.nat == nationality }
                
                self.users.append(contentsOf: frenchUsers)
            } catch {
                NSLog("Error fetching next users: \(error.localizedDescription)")
            }
        }
    }
}
