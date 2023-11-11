//
//  TaskForm.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

struct TaskForm: View {
    
    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var priority = Priority.medium
    @State private var isSheetPresented = false
    @State private var taskItem : TaskModel?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                
                Section(header: Text("Date")) {
                    DatePicker("Select a date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                
                Section(header: Text("Priority")) {
                    Picker("Priority", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { priority in
                            Text(priority.rawValue.capitalized)
                        }
                    }
                }
            }
            .navigationTitle("New Task")
            .navigationBarItems(trailing: SaveButton(action: {
                saveTask()
            }))
        }
    }

    func saveTask() {
        print("Task saved:")
        print("Title: \(String(describing: $title))")
        print("Description: \(String(describing: $description))")
        print("Date: \(String(describing: $date))")
        print("Priority: \(String(describing: $priority))")
        let strDate = "\(date)" 
        let strPriority = "\(priority)" 
        
        FirebaseManager.shared.saveData(title: title, description: description, date: strDate, priority: strPriority) { error in
            if let error = error {
                print("Error saving data: \(error.localizedDescription)")
            } else {
                print("Data saved successfully!")
            }
        }
        
    }
}
