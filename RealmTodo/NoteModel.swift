//
//  NoteModel.swift
//  RealmTodo
//
//  Created by Buka Cakrawala on 4/21/17.
//  Copyright © 2017 Buka Cakrawala. All rights reserved.
//

import Foundation
import RealmSwift

// note model, consists title, content and datestring
class Note: Object {

    dynamic var title = ""
    dynamic var content = ""
    dynamic var dateString = ""
    
}
