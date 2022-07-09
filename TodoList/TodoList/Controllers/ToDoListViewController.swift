//
//  ViewController.swift
//  TodoList
//
//  Created by Dmitry Kaveshnikov on 1/6/22.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (dataFilePath)

        loadItems()
        
        setupNavBar()
        view.backgroundColor = .systemOrange
        configureTableView()
    }
    
    //MARK: Creating TableView Datasource Methods
    
    func configureTableView() {
        tableView.tintColor = .blue
        tableView.rowHeight = 50
        tableView.register(Cell.self, forCellReuseIdentifier: K.reuseCellName)
    }
    
    //MARK: Setup Navigation Bar
    
    func setupNavBar() {
        navigationItem.title = K.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusTaped))
    }
    
    //MARK: Button Actions
    
    @objc private func plusTaped() {
        var textField = UITextField()
        let alert = UIAlertController(title: "And New Item to the List", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
        }
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "Create new Item"
            textField = alertTextFiled
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
         
         do {
             let data = try encoder.encode(itemArray)
             try data.write(to: dataFilePath!)
         } catch {
             print ("Error encodind item array, \(error)")
         }
         self.tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }

}

extension ToDoListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseCellName, for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
