//
//  RemainderTime.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 03.05.23.
//

import SwiftUI

struct RemainderTime: View {
    @EnvironmentObject var habitModel: HabitViewModel
    @Binding var reminder: Reminder
    
//     var onChangeMode: ()-> Void
    
    var body: some View {
           
            VStack(spacing: 10) {
                
                VStack {
                    
                    Text(reminder.title)
                        .foregroundColor(reminder.isOn ? Color(hex: 0x573353) :Color(hex: 0xFDA758 ))
                        .fontWeight(.bold)
                    
                    VStack {
                       // Toggle
                        ZStack {
                            //Background
                            Capsule()
                                .fill(reminder.isOn ? Color(hex: 0x573353).opacity(0.3) : Color(hex: 0xFDA758).opacity(0.3))
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
                                
                                if !reminder.isOn {
                                    Spacer()
                                }
                                Circle()
                                    .fill(reminder.isOn ? Color(hex: 0x573353) :Color(hex: 0xFDA758 ))
                                    .frame(width: 30,height: 25)
                                    .padding(.horizontal,3)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            
                                            self.reminder.isOn = !reminder.isOn
                                 
        //                                    onChangeMode()
                                        }
                                    }
                                    
                                if reminder.isOn {
                                    
                                    Spacer()
                                }
                            }
                            .frame(width: 60)
                            
                        }
                    }
                    .padding(.top,-5)
                }
                .frame(width: 115,height: 80)
                .background(reminder.isOn ? Color(hex: 0x573353).opacity(0.2) : Color(hex: 0xFFF3E9))
                .cornerRadius(10)
                
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
