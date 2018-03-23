//
//  CategoryTableViewController.swift
//  Mytodolist
//
//  Created by TarunKumar Runwal on 3/19/18.
//  Copyright © 2018 TarunKumar Runwal. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: SwipeTableViewController {
    let realm = try! Realm()
    var categoryArray : Results<Category>?
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
       loadCategories()
       tableView.rowHeight = 80.0
    }


    @IBAction func addButonPresed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
           
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

        let cell = super.tableView(tableView, cellForRowAt: indexPath)
       
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added"
        
        
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
    
    //MARK: Deletion Method
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categoryArray?[indexPath.row]{
                do{
                    try self.realm.write {
                        self.realm.delete(categoryForDeletion)
                    }
                }catch {
                    print("error in deletion, \(error)")
                }
            
            }
    }
    
    //MARK: Data Manipulation Methods
    func  save(category : Category){
        
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


