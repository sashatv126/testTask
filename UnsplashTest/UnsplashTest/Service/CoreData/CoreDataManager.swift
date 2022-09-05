//
//  CoreDataManager.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 05.09.2022.
//

import Foundation
import CoreData
import CoreMedia

protocol CoreDataManager {
    func saveFile (name : String,
                   data : String,
                   preview : String,
                   location : String,
                   downloads: Int32,
                   flag: Bool) throws
    func getData() -> [Photo]?
    func delete(name: String) throws
}

enum CoreDataError: Error {
    case saveError
    case saveFileError
}

final class CoreDataBase: CoreDataManager {
    
    // MARK: - Core Data stack
    lazy var  viewContext : NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UnsplashTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - CRUD
    
    func saveContext () throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw CoreDataError.saveError
            }
        }
    }
    
    func saveFile(name : String,
                  data : String,
                  preview : String,
                  location : String,
                  downloads: Int32,
                  flag: Bool
    ) throws {
        let fetchRequrst = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        if let items = try? viewContext.fetch(fetchRequrst) as? [Photo] {
            let file = Photo(context: viewContext)
            file.created = data
            file.url = preview
            file.author = name
            file.downloads = downloads
            file.location = location
            file.flag = flag
            let flag = items.contains(where: {$0.url == preview})
            if !flag {
                do {
                    try saveContext()
                } catch {
                    throw CoreDataError.saveFileError
                }
            }
        }
    }
    
    func getData() -> [Photo]? {
        
        let fetchRequrst = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        if let items = try? viewContext.fetch(fetchRequrst) as? [Photo],
           !items.isEmpty {
            return items
        }
        return nil
    }
    
    func delete(name: String) throws {
        let fetchRequrst = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        let objects = try! viewContext.fetch(fetchRequrst) as! [Photo]
        for obj in objects {
            if obj.author == name {
                viewContext.delete(obj as NSManagedObject)
            }
            
        }
        do {
            try  saveContext()
        } catch {
            throw CoreDataError.saveFileError
        }
    }
}
