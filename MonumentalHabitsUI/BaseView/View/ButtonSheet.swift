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
        
            
            
        VStack(spacing: 10) {
            
            let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
            
            LazyVGrid(columns: columns, spacing: 10) {
                
                ForEach(server){ notification in
                    
                    notificationView(server: notification)
                }
            }
            // Reminder Button
                HStack {
                    
                    Button { } label: {
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
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 20)
        .padding(.horizontal)
        .padding(.top, 20)
        .background(Color.white)
        .cornerRadius (25)
        
        
    }
    
    @ViewBuilder
    
    func notificationView(server: Server)-> some View {
     
        VStack {
            Text(server.time)
            
            VStack {
               // Toggle
                ZStack {
                    //Background
                    Capsule()
                        .fill(isOne ? Color(hex: 0xFFF3E9 ).opacity(0.3) : Color(hex: 0xC8C1C8).opacity(0.3))
                        .frame(width: 50,height: 30)
                    
                    HStack {
                        
                        if !isOne {
                            Spacer()
                        }
                        Circle()
                            .fill(isOne ? Color(hex: 0xFDA758 ) : Color(hex: 0x573353))
                            .frame(width: 30,height: 30)
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
            .padding()
            .background(self.isOne ? Color(hex: 0xFDA758).opacity(0.3) : Color(hex: 0x573353).opacity(0.3))
            .cornerRadius(10)
        
        }
        
    }
}

struct ButtonSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHabits()
    }
}
