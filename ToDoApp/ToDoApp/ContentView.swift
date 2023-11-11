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
                    VStack {
                        Text(task.title)
                        Text(task.description)
                    }
                }
                .onDelete(perform: deleteItem)
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
    
    func deleteItem(at offsets: IndexSet) {
        
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        
    }
    
}

#Preview {
    ContentView()
}
