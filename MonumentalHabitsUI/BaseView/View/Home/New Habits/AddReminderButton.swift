//
//  AddReminderButton.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 03.05.23.
//

import SwiftUI

struct AddReminderButton: View {
    @EnvironmentObject var habitModel: HabitViewModel
    
    var body: some View {
        
        VStack {
            //
            HStack {
                Button(action: {
                    withAnimation {
                        habitModel.showRemainderTime.toggle()
                        habitModel.isAddReminder.toggle()
                    }
                }) {
                    Text("Cansel")
                        .foregroundColor(Color(hex: 0xFC9D45))
                        .fontWeight(.bold)
                }
                Spacer()
                Text("Add Reminders")
                Spacer()
                Button(action: {
                    withAnimation {
                        habitModel.showRemainderTime.toggle()
                        
                        addReminder()
                        
                        habitModel.isAddReminder.toggle()
                    }
                }) {
                    Text("Save")
                        .foregroundColor(Color(hex: 0xFC9D45))
                        .fontWeight(.bold)
                }
            }
            .padding(.top)
            .padding(.bottom)
            // Picker
            Divider()
            VStack {
                HStack {
                    Picker("Hour", selection: $habitModel.remainderDate.hour) {
                        ForEach(0..<24) { hour in
                            Text(String(format: "%02d", hour))
                                .tag(hour)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 80)
                    .formStyle(.automatic)
                    
                    Text(":")
                    
                    Picker("Minute", selection: $habitModel.remainderDate.minute) {
                        ForEach(0..<60) { minute in
                            Text(String(format: "%02d", minute))
                                .tag(minute)
                            
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 80)
                    .accentColor(.red)
                }
                .foregroundColor(Color(hex: 0x573353))
                .font(.title2)
            //Selected Time (PM,AM)
                Picker("", selection: $habitModel.remainderDate.amPM) {
                    Text("AM")
                        .tag(false)
                    
                    Text("PM")
                        .tag(true)
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color(hex: 0xFFF3E9))
            }
            
        }.padding(.horizontal)
            .padding(.bottom,40)
            .background(Color.white)
            .cornerRadius(20)
            .ignoresSafeArea(.all)
    }
    
    func addReminder() {
        habitModel.notificationReminder.append(Reminder(title: "\(habitModel.remainderDate.formatted(date: .omitted, time: .shortened))", isOn: true))
    }
}
