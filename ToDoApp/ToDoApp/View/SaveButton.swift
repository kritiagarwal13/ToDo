//
//  SaveButton.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

struct SaveButton: View {
    var action: () -> Void
    var buttonTitle: () -> Text
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.action()
                }) {
                    buttonTitle()
                }
                .foregroundColor(.accentColor)
                .cornerRadius(30)
                Spacer()
            }
        }
    }
}
