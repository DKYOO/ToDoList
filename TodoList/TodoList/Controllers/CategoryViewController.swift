//
//  CategoryViewController.swift
//  TodoList
//
//  Created by Dmitry Kaveshnikov on 21/7/22.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadCategories()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    func setupNavBar() {
        
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller did not initialize.")
        }
        navBar.prefersLargeTitles = true
        navigationItem.title = K.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navBar.backgroundColor = UIColor(hex: "1D9BF6")
    }
    
    func setupTableView() {
        tableView.tintColor = .black
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.register(Cell.self, forCellReuseIdentifier: K.reuseCellName)
    }
    


    // MARK: - TableView data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
//            cell.makeGradient(colorHex: category.color)
            cell.backgroundColor = UIColor(hex: category.color)
        }
        cell.selectionStyle = .none 
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print ("Error saving category\(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDelete = categories?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(categoryForDelete)
                }
            } catch {
                print("Error deleteting category, \(error)")
            }
        }
    }
 
    //MARK: - Add new Categories
    @objc private func addButtonPressed() {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text ?? ""
            newCategory.color = UIColor.random.toHex()
            self.save(category: newCategory)
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
            destanationVC.selectedCategory = categories?[indexPath.row]
        }
        navigationController?.pushViewController(destanationVC, animated: true)
        
    }
}
