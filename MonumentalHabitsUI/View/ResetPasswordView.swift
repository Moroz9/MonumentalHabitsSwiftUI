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
        
        ZStack {
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                
                //View...
                
                ZStack {
                    VStack {
                        Spacer(minLength: 0)
                        //Image + Text...
                        
                        VStack {
                        
                        Text("FORGOT YOUR PASSWORD?")
                            .padding(.top)
                        
                        Image("Frame 19")
                            .padding(.top)
                    }
                        
                        Spacer(minLength: 0)
                        
                        //View with email check...
                        
                        VStack(spacing: 10) {
                            
                            Text("Enter your registered email below to receive ")
                                .font(.system(size: 14))
                            
                            Text("password reset instruction")
                                .font(.system(size: 14))
                                .padding(.bottom)
                            
                            CustomTextField(image: "messege", plaseHolder: "Email", text: $model.emailReset)
                            
                            Button(action: model.resetPassword) {
                                Text("Send Reset Link")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: 0x573353))
                                    .padding(.horizontal)
                                    .frame(width: UIScreen.main.bounds.width - 60,height: 55)
                                    .background(Color(hex: 0xFDA758))
                                    .cornerRadius(10)
                            }
                            .padding(.bottom)
                        
                        }
                        .padding(.vertical)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.leading)
                        .padding(.trailing)
                        
                        Spacer(minLength: 0)
   
                        // Remember password...
                        
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
                
                // Come back icons ...
                
                Button(action: {model.isReserPassword.toggle()}) {
                    Image("IconsBack")
                        .padding(.vertical,-10)
                        .padding(.horizontal)
                }
                .padding(.leading)
            }
            
            if model.isLoading {
                LoadingView()
            }
        }
        
        //Alert....
        
        .alert(isPresented: $model.alert) {
            Alert(title: Text("Message"),message: Text(model.alertMassage),
                  dismissButton: .destructive(Text("ok"),action: {
                
                // if email link sent means closing the signupView...
                
                if model.alertMassage == "Password Reset Link Has Been Sent !" {
                    model.isReserPassword.toggle()
                    model.emailReset = ""
                }
            }))
        }
    }
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
