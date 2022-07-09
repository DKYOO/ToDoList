//
//  Item.swift
//  TodoList
//
//  Created by Dmitry Kaveshnikov on 6/7/22.
//

import Foundation

class Item: Encodable, Decodable {
    
    var title: String = ""
    var done: Bool = false
     
}
