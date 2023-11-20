//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Kriti Agarwal on 11/11/23.
//

import SwiftUI
import Firebase
import FirebaseInAppMessaging

@main
struct ToDoAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        FirebaseApp.configure()

        return true
    }
}
