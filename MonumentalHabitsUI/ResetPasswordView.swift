//
//  ResetPassword.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 28.04.23.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @StateObject var model = ModelData()
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            
            ZStack {
                VStack {
                    Spacer()
                    Text("FORGOT YOUR PASSWORD?")
                        .padding(.top)
                    Image("Frame 19")
                        .padding(.top)
                    Spacer()
                    VStack {
                        Text("Enter your registered email below to receive ")
                        
                        Text("password reset instruction")
                        
                        CustomTextField(image: "", plaseHolder: "Email", text: $model.emailSignUp)
                        
                        Button(action: {}) {
                            Text("Send Reset Link")
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: 0x573353))
                                .padding(.horizontal)
                                .frame(width: UIScreen.main.bounds.width - 60,height: 55)
                                .background(Color(hex: 0xFDA758))
                                .cornerRadius(10)
                        }
                        .padding(.top,10)
                        .padding(.bottom, 10)
                    
                    }
                    .padding(.top)
                    .padding(.bottom)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.leading)
                    .padding(.trailing)
                    Spacer()
                    HStack() {
                        Text("Remember password?")
                        Button(action: {model.isReserPassword.toggle()}) {
                            Text("Login")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.top)
                    .padding(.bottom)
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color(hex: 0xFFF3E9))
            .ignoresSafeArea()
            
            Button(action: {model.isReserPassword.toggle()}) {
                Image("IconsBack")
                    .padding(.vertical,-10)
                    .padding(.horizontal)
            }
            .padding(.leading)
        }
    }
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
