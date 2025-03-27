//
//  User.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import Foundation

struct UserResponse: Codable {
    let results: [User]
}

struct User: Codable {
    let name: Name
    let location: Location
    let picture: Picture
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Postcode
    let coordinates: Coordinates
}

struct Postcode: Codable {
    let value: String

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            value = String(intValue)
        } else {
            value = try container.decode(String.self)
        }
    }
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

struct Picture: Codable {
    let large: String
    let thumbnail: String
}
