//
//  AppConstants.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI

class Constants {
    enum AppConstants {
        static let cancel = "Cancel"
        static let taskDetails = "Task Details"
        static let title = "Title"
        static let description = "Description"
        static let priority = "Priority"
        static let date = "Date"
        static let isChecked = "isChecked"
        static let update = "Update"
        static let save = "Save"
        static let tasks = "tasks"
        static let task = "task"
        static let titleTasks = "Tasks"
    }

    enum DateFormat {
        static let ddMMyyyy = "dd-MM-yyyy"
        static let locale = "en_US_POSIX"
    }
    
    enum MessageConstants {
        static let selectADate = "Select a date"
        static let itemDeletedSuccessfully = "Item deleted successfully!"
        static let errorFetchingTasks = "Error fetching tasks"
        static let dataSavedSuccessfully = "Data saved successfully!"
    }
    
    enum IconConstants {
        static let add = "plus.circle.fill"
        static let checkmarkSelected = "checkmark.circle.fill"
        static let checkmarkUnselected = "circle"
    }
}

enum Priority: String, CaseIterable {
    case low = "low"
    case medium = "medium"
    case high = "high"
}
