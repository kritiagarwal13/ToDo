//
//  SaveButton.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

struct SaveButton: View {
    var action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.action()
                }) {
                    Text("Save")
                }
                .foregroundColor(.accentColor)
                .cornerRadius(30)
                Spacer()
            }
        }
    }
}
