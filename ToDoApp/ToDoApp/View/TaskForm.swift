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
                Section(header: Text(Constants.AppConstants.taskDetails)) {
                    TextField(Constants.AppConstants.title, text: $title)
                    TextField(Constants.AppConstants.description, text: $description)
                }
                
                Section(header: Text(Constants.AppConstants.date)) {
                    DatePicker(Constants.MessageConstants.selectADate, selection: $date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                
                Section(header: Text(Constants.AppConstants.priority)) {
                    Picker(Constants.AppConstants.priority, selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { priority in
                            Text(priority.rawValue.capitalized)
                        }
                    }
                }
            }
            .onAppear {
                if !viewModel.updateTaskValue {
                    title = ""
                    description = ""
                    date = Date()
                    priority = Priority.low
                }
            }
            .navigationTitle(sheetTitle)
            .navigationBarItems(
                leading: CancelButton(action: {
                    cancelTask()
                }),
                trailing: SaveButton(action: {
                    viewModel.updateTaskValue ? updateTask() : saveTask()
                }) {
                    viewModel.updateTaskValue ? Text(Constants.AppConstants.update) : Text(Constants.AppConstants.save)
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
