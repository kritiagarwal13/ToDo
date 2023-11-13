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
    @Published var updateTask: Bool = false
    @Published var toBeUpdatedTaskId: String = ""
    
    func saveTask(withTitle: String, withDescription: String, withDate: String, withPriority: String, ischecked: Bool) {
        FirebaseManager.shared.saveData(title: withTitle, description: withDescription, date: withDate, priority: withPriority, isChecked: ischecked) { error in
            if let error = error {
                print("Error saving data: \(error.localizedDescription)")
            } else {
                print("Data saved successfully!")
            }
        }
    }
    
    func fetchTasks() {
        FirebaseManager.shared.getTasks { fetchedTasks, error in
            if let error = error {
                print("Error fetching tasks")
            } else if let fetchedTasks = fetchedTasks {
                self.tasks = fetchedTasks.sorted { !$0.isChecked && $1.isChecked }
            }
        }
    }
    
    func deleteTasks(withTaskId: String) {
        FirebaseManager.shared.deleteTask(taskId: withTaskId) { response, error in
            if response == true {
                print("Item deleted successfully!")
            } else {
                print("Error deleting item: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func updateTask(selectedTask: TaskModel) {
        FirebaseManager.shared.updateTask(withTask: selectedTask, withtaskId: toBeUpdatedTaskId)
    }
    
    func formatDate(toStrDate: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormat.ddMMyyyy
        dateFormatter.locale = Locale(identifier: Constants.DateFormat.locale)
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: toStrDate)
    }
    
    func convertStringToDate(from stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormat.ddMMyyyy
        dateFormatter.locale = Locale(identifier: Constants.DateFormat.locale)
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: stringDate)
    }
}
