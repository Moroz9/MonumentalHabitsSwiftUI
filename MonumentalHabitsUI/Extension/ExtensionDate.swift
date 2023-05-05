//
//  Extension.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 04.05.23.
//

import SwiftUI

extension Date {
    func toString(_ format: String)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var hour: Int {
        get { Calendar.current.component(.hour, from: self) }
        set { self = Calendar.current.date(bySettingHour: newValue, minute: minute, second: 0, of: self) ?? self }
    }
    
    var minute: Int {
        get { Calendar.current.component(.minute, from: self) }
        set { self = Calendar.current.date(bySettingHour: hour, minute: newValue, second: 0, of: self) ?? self }
    }
    
    var amPM: Bool {
        get { Calendar.current.component(.hour, from: self) >= 12 }
        set {
            var hour = Calendar.current.component(.hour, from: self)
            if newValue && hour < 12 {
                hour += 12
            } else if !newValue && hour >= 12 {
                hour -= 12
            }
            self = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self) ?? self
        }
    }
}
