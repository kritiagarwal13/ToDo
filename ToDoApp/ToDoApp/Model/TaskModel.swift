//
//  TaskViewModel.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI
struct TaskModel: Identifiable, Hashable {
    var id : String = UUID().uuidString
    let title : String
    let description : String
    let date : Date?
    let priority : Priority

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(date)
        hasher.combine(priority)
    }

    static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        return lhs.id == rhs.id
        return lhs.title == rhs.title
        return lhs.description == rhs.description
        return lhs.date == rhs.date
        return lhs.priority == rhs.priority
    }
}
