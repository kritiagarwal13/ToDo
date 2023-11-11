//
//  TaskViewModel.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

struct TaskModel : Identifiable {

    var id : String = UUID().uuidString
    let name : String
    let description : String
    let taskName : String
    let date : Date
    let priority : Priority
    
}
