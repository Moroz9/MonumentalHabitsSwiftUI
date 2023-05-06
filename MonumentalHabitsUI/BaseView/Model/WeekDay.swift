//
//  WeekDay.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 06.05.23.
//

import SwiftUI

struct WeekDay: Identifiable {
    var id: UUID = .init()
    var string: String
    var date: Date
    var isToday: Bool = false
}
