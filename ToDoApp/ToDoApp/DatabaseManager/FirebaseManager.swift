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
    
    func saveData(title: String, description: String, date: String, priority: String, completion: @escaping (Error?) -> Void) {
        let database = Database.database().reference()
        let taskRef = database.child("tasks").childByAutoId()               //AutoId gives a unique id for retrieval later
        
        let taskData: [String: Any] = [
            "title": title,
            "description": description,
            "date": date,
            "priority": priority
        ]
        
        taskRef.setValue(taskData) { error, _ in
            completion(error)
        }
    }
    
    func getTasks(completion: @escaping ([TaskModel]?, Error?) -> Void) {
        let database = Database.database().reference()
        let tasksRef = database.child("tasks")
        
        tasksRef.observe(.value) { (snapshot: DataSnapshot) in
            guard let tasksData = snapshot.value as? [String: [String: Any]] else {
                let error = NSError(domain: "YourAppDomain", code: 123, userInfo: [NSLocalizedDescriptionKey: "Error converting snapshot data"])
                completion(nil, error as Error)
                return
            }
            
            // mapping tasksData to TaskModel
            let tasks = tasksData.compactMap { (key, value) in
                let stringDate = value["date"] as? String ?? ""
                return TaskModel(id: key,
                                 title: value["title"] as? String ?? "",
                                 description: value["description"] as? String ?? "",
                                 date: self.viewModel.convertStringToDate(from: stringDate),
                                 priority: Priority(rawValue: (value["priority"] as? String)!) ?? .low)
            }
            
            completion(tasks, nil)
        }
    }
    
    func deleteTask(taskId: String, completion: @escaping (Bool, Error?) -> Void) {
        let database = Database.database().reference()
        let tasksRef = database.child("tasks").child(taskId)            //deleting the task node
        
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
        let taskRef = database.child("tasks").child(id)
        
        let strDate = viewModel.formatDate(toStrDate: task.date ?? Date())
        
        // Update the task details
        taskRef.updateChildValues([
            "title": task.title,
            "description": task.description,
            "date": strDate ?? "", // Convert Date to timestamp
            "priority": task.priority.rawValue
        ])
    }
    
}
