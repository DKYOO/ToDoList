//
//  CategoryViewController.swift
//  TodoList
//
//  Created by Dmitry Kaveshnikov on 21/7/22.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureTableView()
        loadCategories()
        view.backgroundColor = .white
    }
    
    func setupNavBar() {
        navigationItem.title = K.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    func configureTableView() {
        tableView.tintColor = .blue
        tableView.rowHeight = 50
        tableView.register(Cell.self, forCellReuseIdentifier: K.reuseCellName)
    }
    


    // MARK: - TableView data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return categories.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseCellName, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories() {
        do { try context.save()
        } catch {
            print ("Error saving category\(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
        categories = try context.fetch(request)
        } catch {
            print ("Error loading categories\(error)")
        }
        tableView.reloadData()
    }
 
    //MARK: - Add new Categories
    @objc private func addButtonPressed() {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()
            
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new Category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destanationVC = ToDoListViewController()
        if let indexPath = tableView.indexPathForSelectedRow {
            destanationVC.selectedCategory = categories[indexPath.row]
        }
        navigationController?.pushViewController(destanationVC, animated: true)
        
    }
    
   

}
