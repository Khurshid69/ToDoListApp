//
//  ListViewModel.swift
//  ToDoListApp
//
//  Created by user on 13/11/21.
//
import Foundation
struct ListViewModel{
    
    var listItems: [ListItem]{
        return CoreDataController.shared.listItems
    }
    
    func addListItem(with name: String){
        
        CoreDataController.shared.addListItem(with: name)
    }
    
    func removeListItem(with name: String?){
        guard let name = name else { return }
        CoreDataController.shared.removeListItem(with: name)

    }
}
