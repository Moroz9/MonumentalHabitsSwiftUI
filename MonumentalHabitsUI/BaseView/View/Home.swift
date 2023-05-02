//
//  Home.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 01.05.23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 10) {

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
                // PlaceHolder ..
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
            }
        }
        .background(Image("Background"),alignment: .bottom)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}

// Extending View To Get Screen Frame
extension View {
    func getRect ()->CGRect{
        return UIScreen.main.bounds
    }
}
