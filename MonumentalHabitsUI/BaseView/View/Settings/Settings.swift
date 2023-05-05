//
//  Settings.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 04.05.23.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationView {
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
                        
                        ZStack {
                            if UIScreen.main.bounds.height < 750 {
                                Image("Mask Group")
                                    .resizable()
                                    .frame(width: 130,height: 100)
                                    .padding(.leading,144)
                            } else {
                                Image("Mask Group")
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: getRect().width / 2.2)
                                    .padding(.leading,144)
                            }
                        }
                        .padding(.top,10)
                        
                        
                        HStack {
                            
                            VStack(alignment: .leading,spacing: 10, content: {
                                Text("Check Your Profile")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: 0x573353))
                                
                                Text("jonathansmith.gmail.com")
                                    .font(.system(size: 11))
                                
                                Button { } label: {
                                    Text("View")
                                        .padding(.horizontal,30)
                                        .padding(.vertical,10)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(hex: 0x573353))
                                        .background(Color(hex: 0xFDA758))
                                        .cornerRadius(10)
                                }
                                .padding(.top, 10)
                                
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
                    .padding(.top,5)
                    
                    
                    // General
                    Text("General").padding(.leading, -UIScreen.main.bounds.width / 2.2)
                    
                    VStack(spacing: 5) {
                        
                        CustomNavigationLinkGeneral(image: "ion:notifications-circle", title: "Notifications", placeHolder: "Customise notifications", content: {
                            Text ("")
                                .navigationTitle("Notifications")
                                .frame (maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(hex: 0xFFF3E9).ignoresSafeArea())
                        })
                        
                        CustomNavigationLinkGeneral(image: "more 1", title: "More customisation", placeHolder: "Customise it more to fit your usage", content: {
                            Text ("")
                                .navigationTitle("More customisation")
                                .frame (maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(hex: 0xFFF3E9).ignoresSafeArea())
                        })
                    }
                    
                    // Support
                    Text("Support").padding(.leading, -UIScreen.main.bounds.width / 2.2)
                    
                    VStack(spacing: 5) {
                        
                        CustomNavigationLinkSupport(image: "chat phone", title: "Contact", content: {
                            Text ("")
                                .navigationTitle("Contact")
                                .frame (maxWidth: .infinity, maxHeight: .infinity)
                                .background (Color(hex: 0xFFF3E9).ignoresSafeArea())
                        })
                        CustomNavigationLinkSupport(image: "facebookImage", title: "Feedback", content: {
                            Text ("")
                                .navigationTitle("Feedback")
                                .frame (maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(hex: 0xFFF3E9).ignoresSafeArea())
                        })
                        CustomNavigationLinkSupport(image: "Group 10075", title: "Privacy Policy", content: {
                            Text ("")
                                .navigationTitle("Privacy Policy")
                                .frame (maxWidth: .infinity, maxHeight: .infinity)
                                .background (Color(hex: 0xFFF3E9).ignoresSafeArea())
                        })
                        CustomNavigationLinkSupport(image: "Group 10043", title: "About", content: {
                            Text ("")
                                .navigationTitle("About")
                                .frame (maxWidth: .infinity, maxHeight: .infinity)
                                .background (Color(hex: 0xFFF3E9).ignoresSafeArea())
                        })
                        
                    }
                    
                }
            }
            .background(Color(hex: 0xFFF3E9))
        }
    }
    
    @ViewBuilder
    func CustomNavigationLinkGeneral<Detail: View>(image: String, title: String, placeHolder: String, @ViewBuilder content:@escaping () ->Detail)->some View {
        
        NavigationLink {
            content()
        } label: {
            HStack {
                
                VStack {
                    Image(image)
                }
                .frame(width: 40,height: 40)
                .background(Color(hex: 0xFDA758).opacity(0.1))
                .cornerRadius(13)
                    
                VStack(alignment: .leading) {
                    
                    Text(title)
                        .foregroundColor(Color(hex: 0x573353))
                    
                    Text(placeHolder)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: 0x573353).opacity(0.4))
                }
                
                Spacer()
                
                Image (systemName: "chevron.right")
                    .foregroundColor(Color(hex: 0x573353))
                    .shadow(color: Color(hex: 0x573353), radius: 5)
                
            }
            .foregroundColor (.black)
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(
            Color.white
                .cornerRadius(12))
        }
        .padding(.horizontal)

    }
    
    func CustomNavigationLinkSupport<Detail: View>(image: String, title: String, @ViewBuilder content:@escaping () ->Detail)->some View {
        
        NavigationLink {
            content()
        } label: {
            HStack {
                
                VStack {
                    Image(image)
                }
                .frame(width: 30,height: 30)
                .background(Color(hex: 0xFDA758).opacity(0.1))
                .cornerRadius(8)
                    
                VStack(alignment: .leading) {
                    
                    Text(title)
                        .foregroundColor(Color(hex: 0x573353))
                }
                
                Spacer()
                
                Image (systemName: "chevron.right")
                    .foregroundColor(Color(hex: 0x573353))
                    .shadow(color: Color(hex: 0x573353), radius: 5)
                
            }
            .foregroundColor (.black)
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(
            Color.white
                .cornerRadius(12))
        }
        .padding(.horizontal)

    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
