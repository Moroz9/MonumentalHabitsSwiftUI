//
//  Server.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 03.05.23.
//

import SwiftUI

struct Server: Identifiable {
   
    var id = UUID().uuidString
    var time: String
    var isOn: Bool
}

var server = [
Server(time: "5.30", isOn: false),
Server(time: "7.30", isOn: true),
Server(time: "8.30", isOn: false),
Server(time: "10.30", isOn: true),
Server(time: "11.30", isOn: false),
Server(time: "13.30", isOn: true),
Server(time: "5.30", isOn: false),
Server(time: "7.30", isOn: true),
Server(time: "8.30", isOn: false),
Server(time: "10.30", isOn: true),
Server(time: "11.30", isOn: false),
Server(time: "13.30", isOn: true)
]
