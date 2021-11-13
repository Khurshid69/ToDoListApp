//
//  ViewController.swift
//  ToDoListApp
//
//  Created by user on 13/11/21.
//

import UIKit

class ListController: UITableViewController {
    

    private var viewModel = ListViewModel()
    
    
// MARK: - @IBActions
    
    @IBAction func addListItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Item", message: "Add an item", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first, let text = textField.text else {
                return
            }
    
            self?.viewModel.addListItem(with: text)
            self?.tableView.reloadData()
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "List Item..."
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        
        present(alertController, animated: true)
    }
    
}





// MARK: - UITableViewDataSource
extension ListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "listItemCell")
        cell.textLabel?.text = viewModel.listItems[indexPath.row].name
        return cell
    }
}



// MARK: - UITableViewDelegete
extension ListController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeListItem(with: viewModel.listItems[indexPath.row].name ?? "")
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
}
