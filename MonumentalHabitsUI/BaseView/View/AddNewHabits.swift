//
//  addNewHabits.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 02.05.23.
//

import SwiftUI

struct AddNewHabits: View {
    @StateObject var baseData = BaseViewModel()
    var body: some View {
        VStack(spacing: 12) {
            
            Text("New Habits")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                       
                    } label: {
                        Image("IconsBack")
                    }
            }
            
            HStack {
                
                TextField("   Enter habits name ", text: $baseData.habitsName)
                    .frame(height: 50)
                    .background(.white)
                    .cornerRadius(15)
                Button {
                    
                } label: {
                    ZStack {
                        VStack {
                            Image("fa-solid:book-reader")
                        }
                        .frame(width: 50,height: 50)
                        .background(.white)
                        .cornerRadius(10)
                        
                        Image("akar-icons:circle-plus-fill")
                            .offset(x: 20, y: -20)
                    }
                }

              
            }
            .padding(.top)
            
          // Calendar
            
            VStack(spacing: 2) {
                HStack {
                    Text("Habit Frequency")
                        .font(.system(size: 19))
                        .foregroundColor(Color(hex: 0x573353))
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Custom")
                        
                        Image(systemName: "chevron.forward")
                    }
                    .foregroundColor(Color(hex: 0xFDA758))
                    .fontWeight(.bold)
                }
                .padding()
                .background(.white)

                    WeekRow()
            }
            .cornerRadius(10)
            
         // Reminder, Notification and Label
            VStack {
                HStack {
                    
                    Text("Reminder")
                        .font(.system(size: 18))
                        .foregroundColor(Color(hex: 0x573353))
    
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Time")
                        Image(systemName: "chevron.forward")
                    }
                    .foregroundColor(Color(hex: 0xFDA758))
                    .fontWeight(.bold)

                   
                    
                }
                .padding()
                .background(.white)
                .cornerRadius(10)

                HStack {
                    Toggle(isOn: $baseData.isNotification) {
                        Text("Notification")
                            .font(.system(size: 18))
                            .foregroundColor(Color(hex: 0x573353))
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color(hex: 0x573353)))
                    
                }
                .padding()
                .background(.white)
                .cornerRadius(10)

                Spacer()
                ZStack {
                    VStack() {
                        Text("START THIS HABIT")
                            .multilineTextAlignment(.center)
                            .font(.title2)
                            .foregroundColor(Color(hex: 0x573353))
                        
                        Text("ullamco laboris nisi ut aliquip ex ea commodo consequat dolore.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(hex: 0x573353))
                        
                        Image("Icon2")
                    }
                    .padding(.top,50)
                    .padding(.horizontal, 50)
                    .padding(.bottom,20)
                    .background(.white)
                    .cornerRadius(10)
                    
                    Image("Image2")
                        .offset(y: -90)
                }
                Spacer()
            }
            
            
        }
        .frame(maxHeight: .infinity,alignment: .top)
        .padding()
        .background(Image("Background"),alignment: .bottom)
        .background(Color(hex: 0xFFF3E9))
        
        
    }
    @ViewBuilder
    func WeekRow()->some View {
        HStack(spacing: 1) {
            ForEach(Calendar.current.currentWeek){weekDay in
                VStack(spacing: 5) {
                    Text(weekDay.string.prefix(3))
                        .foregroundColor(Color(hex: 0x573353))
                    
                    Image("Shape")
                }
                .hAlign(.center)
                .padding(5)
                .background(.white)
                
            }
        }
    }
}

struct addNewHabits_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHabits()
    }
}
extension Date {
    func toString(_ format: String)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Calendar {
    var currentWeek : [WeekDay] {
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else {return []}
        var week: [WeekDay] = []
        for index in 0..<7 {
            if let day = self.date(bySetting: .day, value: index, of: firstWeekDay) {
                let weekDaySymbol: String = day.toString("EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day))
            }
        }
        return week
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}

extension View {
    func hAlign(_ alignment: Alignment)->some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    func Align(_ alignment: Alignment)->some View {
        self
            .frame (maxHeight: .infinity, alignment: alignment)
    }
    
}

