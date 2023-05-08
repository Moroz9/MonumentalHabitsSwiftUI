//
//  RemainderTime.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 03.05.23.
//

import SwiftUI

struct RemainderTime: View {
    @EnvironmentObject var habitModel: HabitViewModel
    @Binding var reminder: [Reminder]
    
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            let columns = Array(repeating: GridItem(.flexible()), count: 3)
            
            LazyVGrid(columns: columns, spacing: 3 ){
                
                ForEach(reminder) { reminderArray in
                    
                    VStack {
                        
                        Text(reminderArray.title)
                            .foregroundColor(reminderArray.isOn ? Color(hex: 0xFDA758 ) : Color(hex: 0x573353))
                            .fontWeight(.bold)
                        
                        VStack {
                            // Toggle
                            ZStack() {
                                //Background
                                Capsule()
                                    .fill(reminderArray.isOn ? Color(hex: 0xFDA758).opacity(0.3) : Color(hex: 0x573353).opacity(0.3))
                                    .frame(width: 55,height: 34)
                                
                                Text("off")
                                    .foregroundColor(.black)
                                    .font(.system(size: 12))
                                    .padding(.leading,20)
                                Text("on")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .padding(.trailing,20)
                                
                                HStack() {
                                    
                                    if reminderArray.isOn {
                                        Spacer()
                                    }
                                    Circle()
                                        .fill(reminderArray.isOn ? Color(hex: 0xFDA758 ) : Color(hex: 0x573353))
                                        .frame(width: 30,height: 25)
                                        .padding(.horizontal,3)
                                        .onTapGesture {
                                            withAnimation() {
                                                
                                            }
                                        }
                                    
                                    if !reminderArray.isOn {

                                        Spacer()
                                    }
                                }
                                .frame(width: 60)
                                
                            }
                        }
                        .padding(.top,-5)
                        
                        
                    }
                    .frame(width: 115,height: 80)
                    .background(reminderArray.isOn ? Color(hex: 0xFFF3E9) : Color(hex: 0x573353).opacity(0.2))
                    .cornerRadius(10)
                }
            }
            // Reminder Button
            HStack {
                
                Button {
                    withAnimation {
                        habitModel.showRemainderTime.toggle()
                        habitModel.isAddReminder.toggle()
                    }
                } label: {
                    Text("Add Reminder")
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: 0x573353))
                        .frame(width: 300, height: 55)
                        .background(Color(hex: 0xFDA758))
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                
                Button { } label: {
                    Image("Reminder Toggle")
                }
                .frame(width: 20,height: 20)
                .padding(.horizontal,20)
                .offset(y: 5)
                
            }.padding(.top)
            
            
        }
        .padding(.bottom,30)
        .padding(.horizontal)
        .padding(.top, 20)
        .background(Color.white)
        .cornerRadius (25)
    }
}
