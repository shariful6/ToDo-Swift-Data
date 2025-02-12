//
//  TaskItemModel.swift
//  ToDo-Swift Data
//
//  Created by Sanjay Kumar on 12/2/25.
//

import Foundation
import SwiftData


@Model
class TaskItemModel{
    var tittle: String
    var details: String
    
    init(tittle: String, details: String) {
        self.tittle = tittle
        self.details = details
    }
}
