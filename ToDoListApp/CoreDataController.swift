//
//  CoreDataController.swift
//  ToDoListApp
//
//  Created by user on 13/11/21.
//

import Foundation
import CoreData



struct CoreDataController {
    static let shared = CoreDataController()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoListApp")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Something went wrong bro. \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    var listItems: [ListItem]{
        
        do {
            return try persistentContainer.viewContext.fetch(NSFetchRequest<ListItem>(entityName: "ListItem"))
        } catch let error {
            print("Unable to save that \(error.localizedDescription)")
            return []
        }
    }
    
    
// MARK: - adding a data
    
    func addListItem(with name: String){
        let listItem = NSEntityDescription.insertNewObject(forEntityName: "ListItem", into: persistentContainer.viewContext) as? ListItem
        listItem?.setValue(name, forKey: "name")
        
        save()
    }
    
    
// MARK: - removing data function
    
    func removeListItem(with name: String){
        let fetchRequest: NSFetchRequest<ListItem> = ListItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@",
                                             argumentArray: ["name", name])
        
        do {
            guard let listTiem = try persistentContainer.viewContext.fetch(fetchRequest).first else {
                return
            }
            
            // delete it
            
            persistentContainer.viewContext.delete(listTiem)
            save()
        }catch let error {
            print("Unable to delete this item \(name). Error: ", error.localizedDescription)
        }
    }
    
    private func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Unable to save. Error: ", error.localizedDescription)
        }
    }
}
