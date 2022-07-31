//
//  StorageManager.swift
//  CoreDataApp
//
//  Created by Felix Titov on 7/30/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation
import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    private let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "CoreDataApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let context: NSManagedObjectContext
    
    private init() {
        context = persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func fetchData(completion: (Result<[Task], Error>) -> Void) {
        let request = Task.fetchRequest()
        
        do {
            let taskList = try context.fetch(request)
            completion(.success(taskList))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func add(_ taskName: String, completion: (Result<Task, Error>) -> Void) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        
        task.title = taskName
        
        saveContext { result in
            switch result {
                
            case .success(_):
                completion(.success(task))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(task: Task, completion: (Result<String, Error>) -> Void) {
        context.delete(task)
        
        saveContext { result in
            switch result {
                
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func edit(_ task: Task, newName: String) {
        task.title = newName
        saveContext { result in
            switch result {
                
            case .success(let message):
                print(message)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func saveContext(completion: (Result<String ,Error>) -> Void) {
        if context.hasChanges {
            do {
                try context.save()
                completion(.success("Success"))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
