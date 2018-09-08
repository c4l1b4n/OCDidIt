//
//  Category.swift
//  OCDidIt
//
//  Created by George Dickson on 9/8/18.
//  Copyright © 2018 George Dickson. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
