//
//  Home.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 01.05.23.
//

import SwiftUI

struct Home: View {
    
    @FetchRequest(entity: Habit.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Habit.dateAdded, ascending: false)],
                  predicate: nil, animation: .easeInOut) var habits: FetchedResults<Habit>
    @StateObject var habitsModel: HabitViewModel = .init()
    
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 10) {
                // PlaceHolder ..
                HStack {
                    
                    Button {
                        
                    } label: {
                        Image("IconsBase")
                    }
                    .padding(.leading,20)
                    Spacer()
                    
                    Image("Image")
                        .padding(.trailing,20)
                }
                .overlay(Text("Homepage")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .font(.title2)
                    .foregroundColor(Color(hex: 0x573353))
                )
                // View ..
                ZStack {
                    
                    Spacer()
                    Image("Mask Group")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: getRect().width / 2.2)
                        .padding(.leading,144)
                    
                    HStack {
                        VStack(alignment: .leading,spacing: 10, content: {
                            Text("WE FIRST MAKE UOR HABITS, AND THEN UOR HABITS MAKES US")
                                .font(.system(size: 16))
                                .lineLimit(3)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: 0x573353))
                            Text("-anonymous")
                                .foregroundColor(Color(hex: 0x573353))
                        })
                        .padding(.trailing,94)
                        .padding(.leading,-5)
                        .padding(.top,-10)
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                ForEach(habits){ habit in
                    habitCardView(habit: habit)
                }
                
            }
            
            ForEach(habits){ habit in
                habitCardView(habit: habit)
            }
           
        }
        .background(Image("Background"),alignment: .bottom)
        .sheet(isPresented: $habitsModel.addNewHabit){
            habitsModel.resetData()
        } content: {
            AddNewHabit()
                .environmentObject(habitsModel)
        }
    }
    
    // MARK: Habit Card View
    @ViewBuilder
    func habitCardView(habit: Habit)->some View {
   
        HStack {
            
            Text("HABITS")
            
            // MARK: Displaying Current Week and Marking Active Dates of Habit
            let calendar = Calendar.current
            let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: Date())
            let symbols = calendar.weekdaySymbols
            let startDate = currentWeek?.start ?? Date()
            let activeWeekDays = habit.weekDays ?? []
            let activePlot = symbols.indices.compactMap { index -> (String, Date) in
                let currentDate = calendar.date (byAdding: .day, value: index, to:
                                                    startDate)
                return (symbols [index], currentDate!)
            }
            HStack(spacing: 0) {
                ForEach(activePlot.indices,id: \.self) { index in
                    let item = activePlot[index]
                    
                    VStack(spacing: 6) {
                        Text (item.0.prefix(3))
                        
                        let status = activeWeekDays.contains { day in
                            return day == item.0
                            
                        }
                        
                        Text(getDate (date: item.1))
                            .font(.system(size: 14))
                            . fontWeight(.semibold)
                            .padding(8)
                            .background {
                                Circle ()
                                    .fill(Color (habit.color ?? "Card-1"))
                                    .opacity (status ? 1 : 0)
                            }
                    }
                }
            }
        }
        .onTapGesture {
            // MARK: Editing Habit
            habitsModel.editHabit = habit
            habitsModel.restoreEditData()
            habitsModel.addNewHabit.toggle()
        }
    }
        
    
    
    // MARK: Formatting Date
    func getDate (date: Date)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
    
}

// Extending View To Get Screen Frame
extension View {
    func getRect ()->CGRect{
        return UIScreen.main.bounds
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(HabitViewModel())
    }
}


