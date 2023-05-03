//
//  AddReminderButton.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 03.05.23.
//

import SwiftUI

struct AddReminderButton: View {
    @ObservedObject var baseData: BaseViewModel
    
    @State private var birthday: Date = Calendar.current.date(byAdding: DateComponents(year: -40),
                                                              to: Date()) ?? Date()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {baseData.isAddReminder.toggle()}) {
                    Text("Cansel")
                        .foregroundColor(Color(hex: 0xFC9D45))
                        .fontWeight(.bold)
                }
                Spacer()
                Text("Add Reminders")
                Spacer()
                Button(action: {baseData.isAddReminder.toggle()}) {
                    Text("Save")
                        .foregroundColor(Color(hex: 0xFC9D45))
                        .fontWeight(.bold)
                }
            }
            .padding(.top)
            .padding(.bottom)
            Divider()
            
            DatePicker(selection: $birthday,displayedComponents: .hourAndMinute){}
                .padding(10)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            
            HStack {
                Button {} label: {
                    Text("AM")
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: 0x573353))
                        .frame(width: 190,height: 55)
                        .background(Color(hex: 0xFDA758))
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                Button {} label: {
                    Text("PM")
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: 0x573353))
                        .frame(width: 190, height: 55)
                        .background(Color(hex: 0xFDA758).opacity(0.4))
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
            
        }.padding(.horizontal)
            .padding(.bottom,40)
            .background(Color.white)
            .cornerRadius(20)
            .ignoresSafeArea(.all)
        
    }
}
    struct AddReminderButton_Previews: PreviewProvider {
        static var previews: some View {
            AddNewHabits()
        }
    }

