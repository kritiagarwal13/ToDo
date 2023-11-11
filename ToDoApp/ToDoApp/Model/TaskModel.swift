//
//  TaskViewModel.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

struct TaskModel : Identifiable {

    var id : String = UUID().uuidString
    let title : String
    let description : String
    let date : Date = Date()
    let priority : Priority = .low
    
}
