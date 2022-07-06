//
//  ViewController.swift
//  TodoList
//
//  Created by Dmitry Kaveshnikov on 1/6/22.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem0 = Item()
        newItem0.title =  "Find Mike"
        newItem0.done = true
        itemArray.append(newItem0)
        
        let newItem1 = Item()
        newItem1.title =  "Buy Eggos"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title =  "Destroy Demo"
        itemArray.append(newItem2)

        if let items = defaults.array(forKey: K.itemArrayKey) as? [Item]  {
            itemArray = items
        }
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
            //add user defaults -> Plist
            self.defaults.set(self.itemArray, forKey: K.itemArrayKey)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "Create new Item"
            textField = alertTextFiled
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
        
        //Vkuritb!
        cell.accessoryType = item.done ? .checkmark : .none
        //vs this
        if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print (itemArray[indexPath.row])
        
        //optimization =)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
