//
//  Category.swift
//  Todoy
//
//  Created by Njål Torgnes Kristensen on 21/10/2019.
//  Copyright © 2019 Norsk Elæring. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>() 
}
