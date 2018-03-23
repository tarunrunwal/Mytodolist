//
//  Category.swift
//  Mytodolist
//
//  Created by TarunKumar Runwal on 3/23/18.
//  Copyright © 2018 TarunKumar Runwal. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
