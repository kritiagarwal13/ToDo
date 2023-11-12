//
//  ContentView.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tasks: [TaskModel] = []
    @StateObject var viewModel = TodoViewModel()
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .fontWeight(.medium)
                                .foregroundStyle(.primary)
                            Text(viewModel.formatDate(toStrDate: task.date) ?? "")
                                .fontWeight(.regular)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text("\(task.priority.rawValue)")
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                    }
                }
                .onDelete { indexSet in
                        for index in indexSet {
                            let deletedTask = viewModel.tasks[index]
                            deleteTask(taskId: deletedTask.id)
                        }
                    }
                .onMove(perform: moveItem)
                
            }
            .navigationTitle("Your Tasks")
            .navigationBarItems(leading: EditButton())
            .sheet(isPresented: $isSheetPresented) {
                TaskForm()
            }
        }
        FloatingAddButton(action: {
            addItem()
        })
        
        .onAppear {
            viewModel.fetchTasks()
        }
    }
    
    func addItem() {
        isSheetPresented.toggle()
    }
    
    func deleteTask(taskId: String) {
        viewModel.deleteTasks(withTaskId: taskId)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        
    }
    
}

#Preview {
    ContentView()
}
