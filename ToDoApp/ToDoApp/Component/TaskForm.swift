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
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button("Save", action: {
                        saveTask()
                    })
                    .frame(width: 120, height: 50)
                    .foregroundColor(.accentColor)
                    .cornerRadius(30)
                    .padding()
                }
            }
            .navigationTitle("New Task")
        }
    }

    func saveTask() {
        print("Task saved:")
        print("Title: \(title)")
        print("Description: \(description)")
        print("Date: \(date)")
        print("Priority: \(priority.rawValue)")
    }
}
