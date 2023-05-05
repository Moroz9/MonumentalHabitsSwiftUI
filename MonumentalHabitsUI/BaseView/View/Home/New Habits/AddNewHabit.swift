//
//  AddNewHabit.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 04.05.23.
//

import SwiftUI

struct AddNewHabit: View {
    @EnvironmentObject var habitModel: HabitViewModel
    @Environment(\.self) var end
    
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
                        
                        
                        //Notification
                        HStack {
                            
                            Text("Notification")
                                .font(.system(size: 18))
                                .foregroundColor(Color(hex: 0x573353))
                            Spacer()
                            
                            notificationVie()
                            
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                    }
                    
                    
                }
                .animation(.easeOut, value: habitModel.isRemainderOn)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle ("New Habit")
                .toolbar{
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            Task {
                                if await habitModel.addHabit(context: end.managedObjectContext){
                                    end.dismiss()
                                }
                            }
                            
                        }) {
                            Image("IconsBack")
                        }
                        .disabled(!habitModel.doneStatus())
                        .opacity(habitModel.doneStatus() ? 1 : 0.6)
                    }
                    
                    
                }
                .background(Color(hex: 0xFFF3E9))
                
                
                VStack {
                    Spacer()
                 
//                    RemainderTime(reminder: habitModel.notificationReminder).offset(y: habitModel.showRemainderTime ? 0 : UIScreen.main.bounds .height)
                    
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
    
    func getIndex(item: Reminder)-> Int {
        return habitModel.notificationReminder.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
    }
    
    func notificationVie()-> some View {
        
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
                                    //                                    onChangeMode()
                                }
                            }
                            .gesture(
                                DragGesture().onEnded({ value in
                                    if value.translation.width > 30 {
                                        //Dark mode
                                        withAnimation(.spring()) {
                                            habitModel.isRemainderOn = false
                                            //                                            onChangeMode()
                                        }
                                    }
                                    
                                    if value.translation.width > -30 {
                                        //Light mode
                                        withAnimation(.spring()) {
                                            habitModel.isRemainderOn = true
                                            //                                            onChangeMode()
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
}
struct AddNewHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHabit()
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
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}
