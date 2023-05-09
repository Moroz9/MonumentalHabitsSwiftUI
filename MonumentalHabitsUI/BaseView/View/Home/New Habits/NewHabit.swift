//
//  NewHabit.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 04.05.23.
//

import SwiftUI

struct NewHabit: View {
    @EnvironmentObject var habitModel: HabitViewModel
    @Environment(\.self) var end
    @State var currentMonth: Int = 0
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack(spacing: 15) {
                    // MARK: Environment Values
                    
                    HStack {
                        TextField("Enter habits name", text: $habitModel.title)
                            .padding(.horizontal)
                            .padding (.vertical,13)
                            .background (Color(.white), in:
                                            RoundedRectangle(cornerRadius: 9, style: .continuous))
                        
                        Button { } label: {
                            ZStack {
                                VStack {
                                    Image("fa-solid:book-reader")
                                        .padding()
                                        .background(.white)
                                }
                                .frame(width: 50,height: 45)
                                .cornerRadius(10)
                                
                                Image("akar-icons:circle-plus-fill")
                                    .offset(x: 20, y: -20)
                            }
                        }
                        
                    }
                    
                    // MARK: Frequency Selection
                    
                    VStack(spacing: 2) {
                        HStack {
                            Text("Habit Frequency")
                                .font(.system(size: 19))
                                .foregroundColor(Color(hex: 0x573353))
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    habitModel.showCalendar.toggle()
                                }
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
                    
                    // MARK: Reminder, Notification
                    VStack {
                        //Reminder
                        HStack {
                            
                            Text("Reminder")
                                .font(.system(size: 18))
                                .foregroundColor(Color(hex: 0x573353))
                            
                            Spacer()
                            Button {
                                withAnimation {
                                    habitModel.showRemainderTime.toggle()
                                }
                            } label: {
                                Text("\(habitModel.remainderDate.formatted(date: .omitted, time: .shortened))")
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundColor(Color(hex: 0xFDA758))
                            .fontWeight(.bold)
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        .frame(height: habitModel.isRemainderOn ? 0 : nil)
                        .opacity(habitModel.isRemainderOn ? 0 : 1)
                        .opacity(habitModel.notificationAccess ? 1 : 0)
                        
                        //Notification
                        HStack {
                            
                            Text("Notification")
                                .font(.system(size: 18))
                                .foregroundColor(Color(hex: 0x573353))
                            Spacer()
                            
                            notificationViewToggle()
                            
                        }
                        .opacity(habitModel.notificationAccess ? 1 : 0)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                    }
                    
                    
                }
                .animation(.easeOut, value: habitModel.isRemainderOn)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle (habitModel.editHabit != nil ? "Edit Habit" : "New Habit")
                .toolbar{
                    //Back
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {end.dismiss()}) {
                            Image("IconsBack")
                        }
                    }
                    // Trash
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            
                            if habitModel.deleteHabit(content: end.managedObjectContext){
                                end.dismiss()
                            }
                        }) {
                            Image(systemName: "trash")
                        }
                        .disabled(!habitModel.doneStatus())
                        .opacity(habitModel.editHabit == nil ? 0 : 1)
                    }
                    //Done
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            Task {
                                if await habitModel.addHabit(context: end.managedObjectContext){
                                    end.dismiss()
                                }
                            }
                        }.disabled(!habitModel.doneStatus())
                            .opacity(habitModel.doneStatus() ? 1 : 0.2)
                    }
                    
                    
                }
                .background(Color(hex: 0xFFF3E9))
                
                
                VStack {
                    Spacer()
                  
                    RemainderTime(reminder: $habitModel.notificationReminder).offset(y: habitModel.showRemainderTime ? 0 : UIScreen.main.bounds .height)
            
                }.background ((habitModel.showRemainderTime ? Color.black.opacity (0.3) : Color.clear).edgesIgnoringSafeArea(.all).onTapGesture {
                    withAnimation {
                        habitModel.showRemainderTime.toggle()
                    }
                })
                .edgesIgnoringSafeArea(.bottom)
                
                
                VStack {
                    Spacer()
                    
                    AddReminderButton(habitModel: _habitModel).offset(y: habitModel.isAddReminder ? 0 : UIScreen.main.bounds .height)
                    
                }.background ((habitModel.isAddReminder ? Color.black.opacity (0.3) : Color.clear).edgesIgnoringSafeArea(.all).onTapGesture {
                    withAnimation {
                        habitModel.isAddReminder.toggle()
                    }
                })
                .edgesIgnoringSafeArea(.bottom)

            }
            
        }
        
    }
    
    @ViewBuilder
    func WeekRow()->some View {
        
        
        ZStack {
            
            HStack(spacing: 1) {

                ForEach(Calendar.current.currentWeek){weekDay in

                    VStack(spacing: 2) {
                        Text(weekDay.string.prefix(3))
                            .foregroundColor(Color(hex: 0x573353))

                        Rectangle()
                             .frame(width: 35,height: 35)
                             .cornerRadius(10)
                             .foregroundColor(Color(habitModel.habitColor))
                     
                    }

                }.hAlign(.center)
                    .padding(.vertical,10)
                    .background(.white)
            }
            .frame(height:
                habitModel.showCalendar ? 100 : nil )
            .opacity(
                habitModel.showCalendar ? 0 : 1)
            .offset(y: habitModel.showCalendar ? UIScreen.main.bounds.height : 5 )

            
            VStack {
                //Days
                let days: [String] =
                ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ]
                
                HStack {
                    // Back
                    Button(action: { withAnimation {currentMonth -= 1}})
                    {
                        Image (systemName: "chevron.left")
                            .foregroundColor(Color(hex: 0x573353))
                            .shadow(color: Color(hex: 0x573353), radius: 5)
                    }
                    .padding()
                    //PlaceHolder
                    Spacer()
                    VStack {
                        Text(extraDate()[0])
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text(extraDate()[1])
                            .font(.title.bold())
                        
                    }
                    //Next
                    Spacer()
                    Button(action: {withAnimation { currentMonth += 1 }}) {
                        Image (systemName: "chevron.right")
                            .foregroundColor(Color(hex: 0x573353))
                            .shadow(color: Color(hex: 0x573353), radius: 5)
                    }
                    .padding()
                }
                
                // Day view
                HStack {
                    
                    ForEach(days,id: \.self){ day in
                        Text (day)
                            .font (.callout)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .padding(.vertical,5)
                
                // Dates
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                
                LazyVGrid(columns: columns, spacing: 3 ){
                    
                    ForEach(extractDate()){ value in
                        
                        CardView(value: value)
         
                    }
                        .padding(4)
                        .background(Color(hex: 0xFFF3E9))
                        .cornerRadius(10)
                }
                
                // Colors view
          
                HStack(spacing: 5) {
                    ForEach(1...6, id: \.self) { id in
                        let color = "Color \(id)"

                        Circle()
                        .foregroundColor(Color(color))
                        .frame(width: 25, height: 25)
                        .overlay(content: {
                            if  color == habitModel.habitColor{
                                Image(systemName: "checkmark")
                                .font(.caption.bold())
                            }
                        })

                        .contentShape(Circle())
                        .onTapGesture {
                            withAnimation {
                                habitModel.habitColor = color
                            }
                        }
                    }

                }
                
                
            }
            .padding(10)
            .frame(height: habitModel.showCalendar ? nil : 0 )
            .opacity(habitModel.showCalendar ? 1 : 0)
            .offset(y: withAnimation {
                habitModel.showCalendar ? 0 : -UIScreen.main.bounds.height
            })
            .background(.white)
            
            
        }
        .onChange(of: currentMonth) { newValue in
            
            habitModel.remainderDate = getCurrentMonth()
        }
        
    }
    
    // View Calendar
    func CardView(value: DateValue)->some View {
        
        VStack {
            
            if value.day != -1 {
                
                Text("\(value.day)")
                    .foregroundColor(Color(hex: 0x573353))
                
                Button(action: {}) {
                    Rectangle()
                        .frame(width: 35,height: 35)
                        .cornerRadius(10)
                        .foregroundColor(Color(habitModel.habitColor))
                }
                .padding(.top,-10)
                
            }
        }
    }
        
    func extraDate()-> [String] {
        
        let formatter = DateFormatter ()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string( from: habitModel.remainderDate)
        
        return date.components (separatedBy: " ")
    }
    
    func getCurrentMonth()-> Date {
        
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
            
        }
        return currentMonth
    }
    
    func getIndex(item: Reminder)-> Int {
        return habitModel.notificationReminder.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
    }
    
    //Notification Toggle
    func notificationViewToggle()-> some View {
        
        VStack {
            VStack {
                // Toggle
                ZStack {
                    //Background
                    Capsule()
                        .fill(habitModel.isRemainderOn ? Color(hex: 0x573353).opacity(0.3) : Color(hex: 0xFDA758).opacity(0.3))
                        .frame(width: 55,height: 34)
                    Text("on")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .padding(.trailing,20)
                    
                    Text("off")
                        .foregroundColor(.black)
                        .font(.system(size: 12))
                        .padding(.leading,20)
                    
                    HStack {
                        
                        if !habitModel.isRemainderOn {
                            Spacer()
                        }
                        Circle()
                            .fill(habitModel.isRemainderOn ? Color(hex: 0x573353) :Color(hex: 0xFDA758 ))
                            .frame(width: 30,height: 25)
                            .padding(.horizontal,3)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    habitModel.isRemainderOn = !habitModel.isRemainderOn
                                }
                            }
                            .gesture(
                                DragGesture().onEnded({ value in
                                    if value.translation.width > 30 {
                                        withAnimation(.spring()) {
                                            habitModel.isRemainderOn = false
                                        }
                                    }
                                    if value.translation.width > -30 {
                                        withAnimation(.spring()) {
                                            habitModel.isRemainderOn = true
                                        }
                                    }
                                })
                            )
                        if habitModel.isRemainderOn {
                            
                            Spacer()
                        }
                    }
                    .frame(width: 60)
                }
            }
        }
    }
    
    func extractDate()-> [DateValue] {
        
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date ())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue (day: -1, date: Date()), at: 0)
        }
        return days
        
    }
    
}


struct NewHabit_Previews: PreviewProvider {
    static var previews: some View {
        NewHabit()
            .environmentObject(HabitViewModel())
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
}
