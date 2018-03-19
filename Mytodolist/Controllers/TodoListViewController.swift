//
//  ViewController.swift
//  Mytodolist
//
//  Created by TarunKumar Runwal on 3/12/18.
//  Copyright © 2018 TarunKumar Runwal. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let newItem = item()
//        newItem.title = "Travel"
//       // newItem.done = true
//        itemArray.append(newItem)
//
//        let newItem1 = item()
//        newItem1.title = "Shop"
//        itemArray.append(newItem1)
//
//        let newItem2 = item()
//        newItem2.title = "Test"
//        itemArray.append(newItem2)
        
        loadItems()
     
//        if let items  = defaults.array(forKey: "TodoListArray") as? [item]{
//            itemArray = items
//    }
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
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else
//        {
//            cell.accessoryType = .none
//        }
        return cell
        
    }
 // TableView Delegate Methods
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
        //tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New MyToDoList Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
             // What will happen when user clicks the add item button on UIAlert
            //print(textField.text!)
            let newItem = item()
            newItem.title = textField.text!
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
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("error encoding item array , \(error)" )
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
      
       if let data = try? Data(contentsOf: dataFilePath!)
        {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([item].self, from: data)
            }catch {
                print("error decoding\(error)")
            }
        }
    }
    
}

