//
//  ButtonSheet.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 03.05.23.
//

import SwiftUI

struct ButtonSheet: View {
    @ObservedObject var serverData: BaseViewModel
    @State var isOne: Bool
    var onChangeMode: ()-> Void
    
    var body: some View {
  
        ZStack {
           
            VStack(spacing: 10) {
                
                let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    
                    ForEach(server){ notification in
                        
                        notificationView(server: notification)
                    }
                }
                // Reminder Button
                HStack {
                    
                    Button {serverData.isAddReminder.toggle() } label: {
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
//            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .padding(.bottom,30)
            .padding(.horizontal)
            .padding(.top, 20)
            .background(Color.white)
            .cornerRadius (25)
            
            
            VStack {
                AddReminderButton(baseData: serverData).offset(y: serverData.isAddReminder ? 0 : UIScreen.main.bounds.height)

            }.background((serverData.isAddReminder ? Color.black.opacity (0.1) : Color.clear).edgesIgnoringSafeArea(.all).onTapGesture {
                serverData.isAddReminder.toggle()
            })
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    @ViewBuilder
    // Create view
    func notificationView(server: Server)-> some View {
     
        VStack {
            Text(server.time)
                .foregroundColor(isOne ? Color(hex: 0x573353) :Color(hex: 0xFDA758 ))
                .fontWeight(.bold)
            
            VStack {
               // Toggle
                ZStack {
                    //Background
                    Capsule()
                        .fill(isOne ? Color(hex: 0x573353).opacity(0.3) : Color(hex: 0xFDA758).opacity(0.3))
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
                        
                        if !isOne {
                            Spacer()
                        }
                        Circle()
                            .fill(isOne ? Color(hex: 0x573353) :Color(hex: 0xFDA758 ))
                            .frame(width: 30,height: 25)
                            .padding(.horizontal,3)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                  isOne = !isOne
                                    onChangeMode()
                                }
                            }
                            .gesture(
                                DragGesture().onEnded({ value in
                                    if value.translation.width > 30 {
                                        //Dark mode
                                        withAnimation(.spring()) {
                                            isOne = false
                                            onChangeMode()
                                        }
                                    }
                                    
                                    if value.translation.width > -30 {
                                        //Light mode
                                        withAnimation(.spring()) {
                                            isOne = true
                                            onChangeMode()
                                        }
                                    }
                                })
                            )
                        if isOne {
                            
                            Spacer()
                        }
                    }
                    .frame(width: 60)
                    
                }
            }
            .padding(.top,-5)
        }
        .frame(width: 115,height: 80)
        .background(self.isOne ? Color(hex: 0x573353).opacity(0.2) : Color(hex: 0xFFF3E9))
        .cornerRadius(10)
    }
}
