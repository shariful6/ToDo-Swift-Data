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
    var isDone: Bool
    
    init(tittle: String, details: String, isDone: Bool) {
        self.tittle = tittle
        self.details = details
        self.isDone = isDone
    }
}
