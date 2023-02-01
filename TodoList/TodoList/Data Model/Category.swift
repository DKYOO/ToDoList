//
//  Category.swift
//  TodoList
//
//  Created by Dmitry Kaveshnikov on 31/1/2023.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
