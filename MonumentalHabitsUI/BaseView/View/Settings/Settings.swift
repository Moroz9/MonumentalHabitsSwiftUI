//
//  Settings.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 04.05.23.
//

import SwiftUI

struct Settings: View {
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
                }
                .overlay(Text("Settings")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .font(.title2)
                    .foregroundColor(Color(hex: 0x573353))
                )
            // View ..
                        ZStack {
                            
                            Spacer()
                            Image("Mask Group")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRect().width / 2.2)
                                .padding(.leading,144)

                            HStack {
                                VStack(alignment: .leading,spacing: 10, content: {
                                    Text("Check Your Profile")
                                        .font(.system(size: 16))
                                        .lineLimit(3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(hex: 0x573353))
                                    
                                    Button(action: {}) {
                                        Text("View")
                                    }
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
            }
        }
        .background(Image("Background"),alignment: .bottom)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
