//
//  Item.swift
//  Mytodolist
//
//  Created by TarunKumar Runwal on 3/23/18.
//  Copyright © 2018 TarunKumar Runwal. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    @objc dynamic var dateCreated : Date?
}
