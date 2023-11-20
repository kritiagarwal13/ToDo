//
//  FirebaseManager.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import Foundation
import Firebase

class FirebaseManager {
    static let shared = FirebaseManager()
    let viewModel = TodoViewModel()
    
    func saveData(title: String, description: String, date: String, priority: String,  isChecked: Bool, completion: @escaping (Error?) -> Void) {
        let database = Database.database().reference()
        let taskRef = database.child(Constants.AppConstants.tasks).childByAutoId()               //AutoId gives a unique id for retrieval later
        
        let taskData: [String: Any] = [
            Constants.AppConstants.title: title,
            Constants.AppConstants.description: description,
            Constants.AppConstants.date: date,
            Constants.AppConstants.priority: priority,
            Constants.AppConstants.isChecked: isChecked
        ]
        
        taskRef.setValue(taskData) { error, _ in
            completion(error)
        }
    }
    
    func getTasks(completion: @escaping ([TaskModel]?, Error?) -> Void) {
        let database = Database.database().reference()
        let tasksRef = database.child(Constants.AppConstants.tasks)
        
        tasksRef.observe(.value) { (snapshot: DataSnapshot) in
            guard let tasksData = snapshot.value as? [String: [String: Any]] else {
                let error = FirError.parsingFailed
                completion(nil, error as Error)
                return
            }
            
            // mapping tasksData to TaskModel
            let tasks = tasksData.compactMap { (key, value) in
                let stringDate = value[Constants.AppConstants.date] as? String ?? ""
                return TaskModel(id: key,
                                 title: value[Constants.AppConstants.title] as? String ?? "",
                                 description: value[Constants.AppConstants.description] as? String ?? "",
                                 date: self.viewModel.convertStringToDate(from: stringDate),
                                 priority: Priority(rawValue: (value[Constants.AppConstants.priority] as? String ?? "")) ?? .low,
                                 isChecked: value[Constants.AppConstants.isChecked] as? Bool ?? false)
            }
            
            completion(tasks, nil)
        }
    }
    
    func deleteTask(taskId: String, completion: @escaping (Bool, Error?) -> Void) {
        let database = Database.database().reference()
        let tasksRef = database.child(Constants.AppConstants.tasks).child(taskId)            //deleting the task node
        
        tasksRef.removeValue { error, _ in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    func updateTask(withTask task: TaskModel, withtaskId id: String) {
        // Update the task in the Realtime Database
        let database = Database.database().reference()
        let taskRef = database.child(Constants.AppConstants.tasks).child(id)
        
        let strDate = viewModel.formatDate(toStrDate: task.date ?? Date())
        
        // Update the task details
        taskRef.updateChildValues([
            Constants.AppConstants.title: task.title,
            Constants.AppConstants.description: task.description,
            Constants.AppConstants.date: strDate ?? "",
            Constants.AppConstants.priority: task.priority.rawValue,
            Constants.AppConstants.isChecked: task.isChecked
        ])
    }
    
}
