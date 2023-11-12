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
    @State private var viewModel = TodoViewModel()
    @Environment(\.presentationMode) var presentationMode
    
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
            .navigationBarItems(
                leading: CancelButton(action: {
                    cancelTask()
                }),
                trailing: SaveButton(action: {
                    saveTask()
                }))
        }
    }
    
    func cancelTask() {
        presentationMode.wrappedValue.dismiss()
    }

    func saveTask() {
        let strDate = viewModel.formatDate(toStrDate: date) ?? ""
        let strPriority = priority.rawValue
        viewModel.saveTask(withTitle: title, withDescription: description, withDate: strDate, withPriority: strPriority)
        presentationMode.wrappedValue.dismiss()
    }
}
