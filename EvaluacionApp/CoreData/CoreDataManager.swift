//
//  CoreDataManager.swift
//  EvaluacionApp
//
//  Created by Sofia Yobal Castro on 9/30/19.
//  Copyright © 2019 Sofia Yobal Castro. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    private let container : NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "UserModel")
        setupDatabase()
    }
    
    private func setupDatabase() {
        
        container.loadPersistentStores {
            (desc, error) in
            if let error = error {
                print("Error loading store \(desc) — \(error)")
                return
            }
            print("Database ready!")
        }
    }
    
    func createUser(name : String, lastName : String, motherLast : String, gender : String, age : Int32, usuario : String, password : String, completion: @escaping() -> Void) {
        
        let context = container.viewContext
        
        let user = User(context: context)
        user.name = name
        user.lastName = lastName
        user.motherName = motherLast
        user.gender = gender
        user.age = age
        user.user = usuario
        user.password = password
        
        do {
            try context.save()
            print("Usuario \(name) guardado")
            completion()
        } catch {
            
            print("Error guardando usuario — \(error)")
        }
    }
    
    func fetchUsers(username: String, password: String) -> Bool {
        // var user: User?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "user = %@", username)
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            
            if results.count > 0 {
                
                if let userRegistered = results.first as? User {
                    
                    if(userRegistered.user == username && userRegistered.password == password){
                       // user = userRegistered
                        return true
                    }
                               
                }
            }
           
        }
        catch {
            print("Failed")
        }
        return false
    }
    
    func fetchUserRepeat(user: String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "user = %@", user)
        do {
           let results = try container.viewContext.fetch(fetchRequest)
           
           if results.count > 0 {  
                /*if let userRegistered = results.first as? User {
                    print(userRegistered.user)
                    return true
                }*/
                return true
            }
        }
       catch {
           print("Failed")
       }
       return false
    }
}
