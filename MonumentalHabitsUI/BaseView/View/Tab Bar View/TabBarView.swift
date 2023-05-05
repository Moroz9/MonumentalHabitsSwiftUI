//
//  BaseView.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 01.05.23.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var habitModel = HabitViewModel()
    
    // isHidden Tab Bar
    init(){
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        TabView(selection: $habitModel.currentTab) {
            Home()
                .environmentObject(habitModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: 0xFFF3E9))
                .tag(Tab.Home)
            Text("Courses")
                .tag(Tab.Courses)
            Text("Community")
                .tag(Tab.Community)
            Settings()
                .tag(Tab.Settings)
        }
        .overlay(
            
            
            // Custom tab bar
            HStack(spacing: 0) {
                TabButton(Tab: .Home)
                    .offset(y: 15)
                TabButton(Tab: .Courses)
                    .offset(x: -10,y: 15)
                
                // Center Add Button
                
                Button {
                    withAnimation (Animation.default.speed (0.3)){
                        habitModel.newHabit.toggle()
                    }
                    } label: {
                    
                    Image(habitModel.newHabit ? "Check Button" : "AddNewHabits" )
                        .padding(18)
                        .background(Color(hex: 0xFC9D45))
                        .clipShape(Circle())
                        .shadow(color: Color(hex: 0xFC9D45).opacity(0.3), radius: 5,x: 0,y: 5)
                        .shadow(color: Color(hex: 0xFC9D45).opacity(0.3), radius: 5,x: 0,y: -5)
                        .offset(y: -30)
                }
                .shadow(color: Color(hex: 0xFC9D45).opacity(0.3), radius: 5,x: 0,y: 5)
                .shadow(color: Color(hex: 0xFC9D45).opacity(0.3), radius: 5,x: 0,y: -5)
                
                
                TabButton(Tab: .Community)
                    .offset(x: 10,y: 15)
                TabButton(Tab: .Settings)
                    .offset(y: 15)
            }
                .frame(height: 40)
                .background(
                    Color.white
                        .clipShape(CustomCurveShape())
                        .ignoresSafeArea(.container, edges: .bottom)
                )
            ,alignment: .bottom
        )
        
    }
    @ViewBuilder
    
    func TabButton(Tab: Tab)-> some View {
        
        Button {
            withAnimation {
                habitModel.currentTab = Tab
            }
        } label: {
            Image(Tab.rawValue)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 25,height: 25)
                .colorMultiply(habitModel.currentTab == Tab ? Color.white : Color.gray)
                .frame(maxWidth: .infinity)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
