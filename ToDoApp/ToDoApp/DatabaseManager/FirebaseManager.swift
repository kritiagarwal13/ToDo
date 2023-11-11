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
    
    func saveData(title: String, description: String, date: String, priority: String, completion: @escaping (Error?) -> Void) {
        let database = Database.database().reference()
        let taskRef = database.child("tasks").childByAutoId()
        
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
            
            // Map tasksData to TaskModel or your custom model
            let tasks = tasksData.compactMap { (key, value) in
                return TaskModel(id: key, title: value["title"] as? String ?? "", description: value["description"] as? String ?? "")
            }
            
            completion(tasks, nil)
        }
    }
    
}
