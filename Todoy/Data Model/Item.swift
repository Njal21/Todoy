//
//  Item.swift
//  Todoy
//
//  Created by Njål Torgnes Kristensen on 21/10/2019.
//  Copyright © 2019 Norsk Elæring. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
