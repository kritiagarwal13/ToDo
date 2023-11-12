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
    @State private var isSheetPresented = false
    @State private var selectedTask: TaskModel?

    var body: some View {
            NavigationView {
                List(selection: $selectedTask) {
                    ForEach(viewModel.tasks, id: \.id) { task in
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
                        .onTapGesture {
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
                .navigationTitle("Your Tasks")
                .navigationBarItems(leading: EditButton())
                .sheet(isPresented: $isSheetPresented) {
                    TaskForm(title: $title, description: $description, date: $date, priority: $priority, viewModel: viewModel, sheetTitle: "Task")
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
}

#Preview {
    ContentView()
}
