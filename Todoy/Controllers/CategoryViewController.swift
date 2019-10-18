//
//  CategoryViewControllerTableViewController.swift
//  Todoy
//
//  Created by Njål Torgnes Kristensen on 18/10/2019.
//  Copyright © 2019 Norsk Elæring. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewControllerTableViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).PersistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSelector(inBackground: "goToItems", with: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destiationVC = segue.description as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destiationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    func saveCategories() {
        do {
        try context.save()
        } catch {
            print("Error saving category, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
        categories = try context.fetch(request)
        } catch {
            print("Error loading categorings \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
