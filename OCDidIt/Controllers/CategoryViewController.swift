//
//  CategoryViewController.swift
//  OCDidIt
//
//  Created by George Dickson on 9/7/18.
//  Copyright © 2018 George Dickson. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
     var categoryArray = [Category]()
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }

    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
        
    }
    
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
        
    }
    
    //MARK: - TableView Data Manipulation Methods
    
    func loadCategories (with request: NSFetchRequest<Category> = Category.fetchRequest ()) {

        do {
            categoryArray = try context.fetch(request)
        } catch {
            print ("Error fetching the data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func saveCategories(){
        
        do {
            
            try context.save()
            
        } catch {
            
            print ("Error saving category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - Add new Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add A New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on the UIAlert
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
        }
        
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        saveCategories()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
