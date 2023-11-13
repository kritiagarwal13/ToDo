//
//  ContentView.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = TodoViewModel()
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var priority: Priority = .low
    @State private var isChecked: Bool = false
    @State private var isSheetPresented = false
    @State private var selectedTask: TaskModel?

    var body: some View {
        NavigationView {
            if viewModel.tasks.isEmpty {
                Text("Start Adding Tasks")
                    .foregroundColor(.secondary)
                    .font(.title3)
                    .padding()
            } else {
                List(selection: $selectedTask) {
                    ForEach(viewModel.tasks.indices, id: \.self) { index in
                        let task = viewModel.tasks[index]
                        
                        HStack {
                            Checkbox(isChecked: $viewModel.tasks[index].isChecked)
                            // to handle the checkbox tap
                                .onTapGesture {
                                    toggleCheckbox(at: index)
                                }
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(task.title)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.primary)
                                    Text(viewModel.formatDate(toStrDate: task.date ?? Date()) ?? "")
                                        .fontWeight(.regular)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text("\(task.priority.rawValue)")
                                    .fontWeight(.regular)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .contentShape(Rectangle()) // to ensure task details open on clicking anywhere in the cell
                        .onTapGesture {
                            // to handle the normal cell tap
                            openTask(withTaskId: task.id)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let deletedTask = viewModel.tasks[index]
                            deleteTask(taskId: deletedTask.id)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle(Constants.AppConstants.titleTasks)
                .navigationBarItems(leading: EditButton())
                .sheet(isPresented: $isSheetPresented) {
                    TaskForm(title: $title, description: $description, date: $date, priority: $priority, isChecked: $isChecked, viewModel: viewModel, sheetTitle: Constants.AppConstants.task)
                }
            }
        }
        FloatingAddButton(action: {
            addTask()
        })
        .onAppear {
            viewModel.fetchTasks()
        }
    }

    func addTask() {
        viewModel.updateTask = false
        isSheetPresented.toggle()
    }

    func deleteTask(taskId: String) {
        viewModel.deleteTasks(withTaskId: taskId)
    }

    func openTask(withTaskId taskId: String) {
        viewModel.updateTask = true
        viewModel.toBeUpdatedTaskId = taskId
        if let task = viewModel.tasks.first(where: { $0.id == taskId }) {
            title = task.title
            description = task.description
            date = task.date ?? Date()
            priority = task.priority
        }
        isSheetPresented.toggle()
    }
    
    func toggleCheckbox(at index: Int) {
        viewModel.tasks[index].isChecked.toggle()
        viewModel.toBeUpdatedTaskId = viewModel.tasks[index].id
        viewModel.updateTask(selectedTask: viewModel.tasks[index])
    }
}

#Preview {
    ContentView()
}
