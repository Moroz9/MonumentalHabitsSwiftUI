//
//  BaseViewModel.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 01.05.23.
//

import SwiftUI
import CoreData

class BaseViewModel: ObservableObject {
    // Tab Bar
    @Published var currentTab: Tab = .Home
    
    //HabitsViewModel
    @Published var openEditHabits = false
    @Published var isNotification = false
    @Published var habitsTitle = ""
    @Published var habitsColor = "Yellow"
    @Published var habitsDiedLine = Date()
    @Published var habitsType = "basic"
    
    @Published var habitsName = ""
    
    //Button Sheet 
    @Published var isConnected = false
    @Published var showSheet = false
    
    // AddReminder Button
    @Published var isAddReminder = false
    
}

// Enum case for Tab items

enum Tab: String {
    case Home = "Home"
    case Courses = "Courses"
    case AddNewHabits = "AddNewHabits"
    case Community = "Community"
    case Settings = "Settings"
}
