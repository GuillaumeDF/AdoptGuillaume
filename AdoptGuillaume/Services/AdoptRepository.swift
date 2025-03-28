//
//  AdoptRepository.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

protocol AdoptRepositoryProtocol {
    func fetchCoreData() -> [User]?
    func saveCoreDataUsers(users: [User])
    
    func fetchApiUser(numberOfUsers: Int, nationalities: [String]) async throws -> [User]
}

final class AdoptRepository: AdoptRepositoryProtocol {
    private let coreDataSource: any CoreDataSourceProtocol
    private let apiDataSource: any ApiProtocol
    
    init(coreDataSource: any CoreDataSourceProtocol, apiDataSource: any ApiProtocol) {
        self.coreDataSource = coreDataSource
        self.apiDataSource = apiDataSource
    }
    
    func fetchCoreData() -> [User]? {
        coreDataSource.fetchUsers()
    }
    
    func saveCoreDataUsers(users: [User]) {
        coreDataSource.saveUsers(users: users)
    }
    
    func fetchApiUser(numberOfUsers: Int, nationalities: [String]) async throws -> [User] {
        try await apiDataSource.fetch(numberOfUsers: numberOfUsers, nationalities: nationalities)
    }
}
