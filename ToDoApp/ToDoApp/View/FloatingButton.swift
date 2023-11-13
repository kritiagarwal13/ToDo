//
//  FloatingButton.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

struct FloatingAddButton: View {
    var action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.action()
                }) {
                    Image(systemName: Constants.IconConstants.add)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.accentColor)
                        .padding()
                }
                .cornerRadius(30)
                Spacer()
            }
        }
    }
}
