//
//  ViewController.swift
//  Todoey
//
//  Created by RAMA RAO KONERU on 8/21/18.
//  Copyright © 2018 RAMA RAO KONERU. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray=[Item]()
    
    let defaults=UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem=Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        
        let newItem1=Item()
        newItem1.title = "Buy Eggs"
        itemArray.append(newItem1)
        
        if let items=defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray=items
        }
    }
    
    
    // Mark Tableview Data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for :indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text=item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the button on the ui alert
            
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            print("Success!")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new item"
            
            
            textField=alertTextField
            
        }
        
        
        alert.addAction(action)
        
        self.present(alert,animated: true,completion: nil)
        
    }
    
}

