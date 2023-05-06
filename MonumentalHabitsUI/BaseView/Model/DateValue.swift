//
//  DateValue.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 06.05.23.
//

import SwiftUI

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
