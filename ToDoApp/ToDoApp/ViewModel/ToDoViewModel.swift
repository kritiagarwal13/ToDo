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
    
    func saveTask(withTitle: String, withDescription: String, withDate: String, withPriority: String) {
        FirebaseManager.shared.saveData(title: withTitle, description: withDescription, date: withDate, priority: withPriority) { error in
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
                print("Error fetching tasks: \(error.localizedDescription)")
            } else if let fetchedTasks = fetchedTasks {
                self.tasks = fetchedTasks
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
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set a specific locale if needed
        dateFormatter.timeZone = TimeZone.current // Set a specific timezone if needed
        return dateFormatter.string(from: toStrDate)
    }
    
    func convertStringToDate(from stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set a specific locale if needed
        dateFormatter.timeZone = TimeZone.current // Set a specific timezone if needed
        return dateFormatter.date(from: stringDate)
    }
    
    func dateToTimestamp(_ date: Date) -> TimeInterval {
        return date.timeIntervalSince1970
    }

    func timestampToDate(_ timestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }
    
}
