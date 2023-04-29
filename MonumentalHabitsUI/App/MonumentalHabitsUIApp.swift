//
//  MonumentalHabitsUIApp.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 27.04.23.
//

import SwiftUI
import FirebaseCore

@main
struct MonumentalHabitsUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
