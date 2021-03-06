//
//  DataHandler.swift
//  PlanetSample
//
//  Created by C, Maheswaran (Cognizant) on 20/06/21.
//

import UIKit
import CoreData


class DataHandler{
    
    static let shared = DataHandler()
    private init(){}
    
   
    private let viewContext = (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext
    
    func add<T:NSManagedObject>(_ type: T.Type) -> T?{
        guard let entityName = T.entity().name else {return nil}
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else {return nil}
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    
    func fetch<T:NSManagedObject>(_ type: T.Type) -> [T]?{
        let request = T.fetchRequest()
        do{
            let result = try viewContext.fetch(request)
            return result as? [T]
        }catch{
            print(error.localizedDescription)
            return[]
        }
    }
    
    func save(){
        do {
            try viewContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
              viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
