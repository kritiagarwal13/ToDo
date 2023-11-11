//
//  ContentView.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [String] = ["Item 1", "Item 2", "Item 3"]
    @State private var newItem = ""
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
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
            isSheetPresented.toggle()
        })
    }
    
    func addItem() {
        let newItem = "New Item \(items.count + 1)"
        items.append(newItem)
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
}

#Preview {
    ContentView()
}
