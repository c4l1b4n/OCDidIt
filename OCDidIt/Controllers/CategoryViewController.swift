//
//  CategoryViewController.swift
//  OCDidIt
//
//  Created by George Dickson on 9/7/18.
//  Copyright © 2018 George Dickson. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    loadCategories()
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
        
    }
    
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added"
        
        return cell
        
    }
    
    //MARK: - TableView Data Manipulation Methods
    
    func loadCategories() {
        
        categoryArray = realm.objects(Category.self)

        tableView.reloadData()
        
    }
    
    func save(category: Category){
        
        do {
            
            try realm.write{
                
                realm.add(category)
                
            }
            
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
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
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
        performSegue(withIdentifier: "goToItems", sender: self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
            
        }
    }
}
