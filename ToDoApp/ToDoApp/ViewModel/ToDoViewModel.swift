//
//  ToDoViewModel.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import Foundation
import Firebase

class TodoViewModel: ObservableObject {
   
    @Published var tasks: [TaskModel] = []
    
    func fetchTasks() {
        FirebaseManager.shared.getTasks { fetchedTasks, error in
            if let error = error {
                print("Error fetching tasks: \(error.localizedDescription)")
            } else if let fetchedTasks = fetchedTasks {
                self.tasks = fetchedTasks
            }
        }
    }
    
}
