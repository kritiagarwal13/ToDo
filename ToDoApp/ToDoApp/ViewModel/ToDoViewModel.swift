//
//  ToDoViewModel.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import Foundation

class TodoViewModel: ObservableObject {
   
    @Published var tasks: [TaskModel] = []
    
    func fetchTasks() {
        // fetch tasks from Firebase
    }
    
}
