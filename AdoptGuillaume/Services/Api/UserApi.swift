//
//  UserApi.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import Foundation

class UserApi: ApiProtocol {
    typealias DecodedData = UserResponse
    
    var session: URLSession
    var url: URL?
    var httpMethod: HTTPMethod {
        .get
    }
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch(numberOfUsers: Int = 50, nationalities: [String] = ["fr", "us", "gb", "de", "es"]) async throws -> [User] {
        do {
            let parameters: [String: String] = [
                "results": "\(numberOfUsers)",
                "nat": nationalities.joined(separator: ",")
            ]
            
            let data = try await getData(parameters: parameters)
            let users = try decodeResponse(from: data)
            
            return users.results
        } catch {
            throw error
        }
    }
}
