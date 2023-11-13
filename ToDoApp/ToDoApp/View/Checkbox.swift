//
//  Checkbox.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 13/11/23.
//

import SwiftUI

struct Checkbox: View {
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}
