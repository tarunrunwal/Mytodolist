//
//  SwipeTableViewController.swift
//  Mytodolist
//
//  Created by TarunKumar Runwal on 3/23/18.
//  Copyright © 2018 TarunKumar Runwal. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController,SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            self.updateModel(at: indexPath)
//            if let categoryForDeletion = self.categoryArray?[indexPath.row]{
//                do{
//                    try self.realm.write {
//                        self.realm.delete(categoryForDeletion)
//                    }
//                }catch {
//                    print("error in deletion, \(error)")
//                }
//                print("item deleted")
//                // handle action by updating model with deletion
//
//                //tableView.reloadData()
//            }
            
            print("dele")
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        //options.transitionStyle = .border
        return options
    }
  
    
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        //let item = categoryArray[indexPath.row]
        cell.delegate = self
        //cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added"
        
        // cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    func updateModel(at indexPath: IndexPath){
        
    }
}

