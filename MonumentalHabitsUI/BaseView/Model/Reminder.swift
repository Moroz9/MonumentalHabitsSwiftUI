//
//  Reminder.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 03.05.23.
//

import SwiftUI

struct Reminder: Identifiable {
    var id = UUID().uuidString
    var title: String
    var isOn: Bool
}
