//
//  CategoryTableViewController.swift
//  Mytodolist
//
//  Created by TarunKumar Runwal on 3/19/18.
//  Copyright © 2018 TarunKumar Runwal. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    let realm = try! Realm()
    var categoryArray : Results<Category>?
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
       loadCategories()
       
    }


    @IBAction func addButonPresed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // What will happen when user clicks the add item button on UIAlert
            //print(textField.text!)
            let newCategory = Category()
            newCategory.name = textField.text!
            //newItem.done = false
            //self.categoryArray.append(newCategory)
            //  self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.save(category: newCategory)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        //let item = categoryArray[indexPath.row]
        
       cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added"
        
       // cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // categoryArray[indexPath.row].done = !itemArray[indexPath.row].done
        performSegue(withIdentifier: "goToItem", sender: self)
        //saveCategories()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC =  segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    //MARK: Data Manipulation Methods
    func  save(category : Category){
        // let encoder = PropertyListEncoder()
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("error saving context , \(error)" )
        }
        tableView.reloadData()
    }
    
    func loadCategories(){

        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }

    
}
