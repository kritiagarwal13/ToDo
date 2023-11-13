//
//  TaskForm.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

struct TaskForm: View {
    
    @Binding var title: String
    @Binding var description: String
    @Binding var date: Date
    @Binding var priority: Priority
    @Binding var isChecked: Bool
    @State private var isSheetPresented = false
    @ObservedObject var viewModel = TodoViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var sheetTitle: String
    
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
            .navigationTitle(sheetTitle)
            .navigationBarItems(
                leading: CancelButton(action: {
                    cancelTask()
                }),
                trailing: SaveButton(action: {
                    viewModel.updateTask ? updateTask() : saveTask()
                }) {
                    viewModel.updateTask ? Text("Update") : Text("Save")
                }
            )
        }
    }
    
    func cancelTask() {
        presentationMode.wrappedValue.dismiss()
    }

    func saveTask() {
        let strDate = viewModel.formatDate(toStrDate: date) ?? ""
        viewModel.saveTask(withTitle: title, withDescription: description, withDate: strDate, withPriority: priority.rawValue, ischecked: false)
        presentationMode.wrappedValue.dismiss()
    }
    
    func updateTask() {
        let taskToBeUpdated = TaskModel(id: viewModel.toBeUpdatedTaskId, title: title, description: description, date: date, priority: priority, isChecked: isChecked)
        viewModel.updateTask(selectedTask: taskToBeUpdated)
        presentationMode.wrappedValue.dismiss()
    }
}
