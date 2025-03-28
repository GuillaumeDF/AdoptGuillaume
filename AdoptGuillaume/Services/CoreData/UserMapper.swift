//
//  UserMapper.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 28/03/2025.
//

import CoreData

struct UserMapper {
    static func mapToUserEntity(user: User, context: NSManagedObjectContext) -> UserEntity {
        let userEntity = UserEntity(context: context)
        userEntity.id = user.id
        userEntity.firstName = user.name.first
        userEntity.lastName = user.name.last
        userEntity.street = user.location.street.name
        userEntity.city = user.location.city
        userEntity.state = user.location.state
        userEntity.country = user.location.country
        userEntity.postcode = user.location.postcode.value
        userEntity.latitude = user.location.coordinates.latitude
        userEntity.longitude = user.location.coordinates.longitude
        userEntity.age = Int16(user.dob.age)
        userEntity.pictureLarge = user.picture.large
        userEntity.pictureMedium = user.picture.medium
        userEntity.nat = user.nat
        
        return userEntity
    }
    
    static func mapToUser(userEntity: UserEntity) -> User {
        let name = Name(first: userEntity.firstName ?? "", last: userEntity.lastName ?? "")
        let location = Location(
            street: Street(number: Int(userEntity.streetNumber), name: userEntity.street ?? ""),
            city: userEntity.city ?? "",
            state: userEntity.state ?? "",
            country: userEntity.country ?? "",
            postcode: Postcode(value: userEntity.postcode ?? ""),
            coordinates: Coordinates(latitude: userEntity.latitude ?? "", longitude: userEntity.longitude ?? "")
        )
        let dob = Dob(age: Int(userEntity.age))
        let picture = Picture(large: userEntity.pictureLarge ?? "", medium: userEntity.pictureMedium ?? "")
        let login = Login(uuid: userEntity.id ?? "")
        
        return User(
            id: userEntity.id ?? "",
            name: name,
            location: location,
            dob: dob,
            picture: picture,
            login: login,
            nat: userEntity.nat ?? ""
        )
    }
}
