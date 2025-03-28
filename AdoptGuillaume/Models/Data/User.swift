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

struct User: Codable, Identifiable {
    let id: String
    let name: Name
    let location: Location
    let dob: Dob
    let picture: Picture
    let login: Login
    let nat: String
    
    init(id: String, name: Name, location: Location, dob: Dob, picture: Picture, login: Login, nat: String) {
        self.id = id
        self.name = name
        self.location = location
        self.dob = dob
        self.picture = picture
        self.login = login
        self.nat = nat
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(Name.self, forKey: .name)
        location = try container.decode(Location.self, forKey: .location)
        dob = try container.decode(Dob.self, forKey: .dob)
        picture = try container.decode(Picture.self, forKey: .picture)
        login = try container.decode(Login.self, forKey: .login)
        nat = try container.decode(String.self, forKey: .nat)
        id = login.uuid
    }
}

struct Login: Codable {
    let uuid: String
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
    
    init(value: String) {
        self.value = value
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

struct Dob: Codable {
    let age: Int
}

struct Picture: Codable {
    let large: String
    let medium: String
}
