//
//  CancelButton.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 12/11/23.
//

import SwiftUI

struct CancelButton: View {
    var action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.action()
                }) {
                    Text(Constants.AppConstants.cancel)
                }
                .foregroundColor(.accentColor)
                .cornerRadius(30)
                Spacer()
            }
        }
    }
}
