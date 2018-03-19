//
//  ViewController.swift
//  Mytodolist
//
//  Created by TarunKumar Runwal on 3/12/18.
//  Copyright © 2018 TarunKumar Runwal. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first?.appendingPathComponent("Items.plist")
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory,in: .userDomainMask))

        
        //loadItems()
     
        }
    

    //Tableview Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
       let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
 // TableView Delegate Methods
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New MyToDoList Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
             // What will happen when user clicks the add item button on UIAlert
            //print(textField.text!)
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.theParentCategory = self.selectedCategory
            self.itemArray.append(newItem)
          //  self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
           self.saveItems()
      
        }
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func  saveItems(){
       // let encoder = PropertyListEncoder()
        do{
           try context.save()
        }catch{
            print("error saving context , \(error)" )
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate :NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "theParentCategory.name MATCHES %@", selectedCategory!.name! )
        print(selectedCategory!.name!)
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:  [categoryPredicate, additionalPredicate])
        }
        else{
            request.predicate = categoryPredicate
        }
        
        
        
        do{
            itemArray = try context.fetch(request)
        }
        catch{
            print("error retrieving data, \(error)")
        }
        tableView.reloadData()
    }
    
}

//MARK: Search Functionality
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        //print(searchBar.text!)
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        
        //Sort
         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        //load details
        loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
}


