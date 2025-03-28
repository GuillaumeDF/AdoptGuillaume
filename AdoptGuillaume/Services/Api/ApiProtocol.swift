//
//  ApiProtocol.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol ApiProtocol {
    associatedtype DecodedData: Decodable
    
    var session: URLSession { get set }
    var httpMethod: HTTPMethod { get }
    
    func fetch(numberOfUsers: Int, nationalities: [String]) async throws -> [User]
}

extension ApiProtocol {
    
    func createUrl(_ parameters: [String: String] = [:]) throws -> URL {
        var urlComponents = URLComponents(string: URLS.baseURL)
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        return url
    }
    
    func getData(parameters: [String: String] = [:]) async throws -> Data {
        let url = try createUrl(parameters)
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
    
    func decodeResponse(from data: Data) throws -> DecodedData {
        let decoder = JSONDecoder()
        
        do {
            let data = try decoder.decode(DecodedData.self, from: data)
            
            return data
        } catch {
            throw error
        }
    }
}
