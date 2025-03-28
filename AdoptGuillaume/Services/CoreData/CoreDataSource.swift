//
//  CoreDataSource.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 28/03/2025.
//

import Foundation
import CoreData

protocol CoreDataSourceProtocol {
    func saveUsers(users: [User])
    func fetchUsers() -> [User]?
}

class CoreDataSource: CoreDataSourceProtocol {
    static let shared = CoreDataSource()
    private(set) var persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "AdoptGuillaume")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveUsers(users: [User]) {
        context.performAndWait {
            for user in users {
                _ = UserMapper.mapToUserEntity(user: user, context: context)
            }
            
            do {
                try save()
            } catch {
                NSLog("Error saving users: \(error)")
            }
        }
    }
    
    func fetchUsers() -> [User]? {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            let userEntities = try context.fetch(fetchRequest)
            return userEntities.map { UserMapper.mapToUser(userEntity: $0) }
        } catch {
            NSLog("Error fetching users: \(error)")
            return nil
        }
    }
    
    func save() throws {
        var saveError: Error?
        
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    saveError = error
                }
            }
        }
        
        if let error = saveError {
            throw error
        }
    }
}
