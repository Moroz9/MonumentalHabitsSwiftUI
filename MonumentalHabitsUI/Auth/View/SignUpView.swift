//
//  SignUp.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 28.04.23.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var model = ModelData()
    
    var body: some View {
        
        
        ZStack {
            
            ZStack {
                
                VStack() {
                    Spacer(minLength: 0)
                    // Create bounds images on the screen...
                    
                    VStack {
                        
                        ZStack {
                            if UIScreen.main.bounds.height < 750 {
                                Image("Create Your Account")
                                    .resizable()
                                    .frame(width: 130,height: 130)
                            } else {
                                Image("Create Your Account")
                            }
                        }
                        .padding(.top)
                        
                        Text("CREATE YOUR ACCOUNT")
                    }
                    .padding(.horizontal)
                    .padding(.top,0)
                 
                    // CustomTextFields...
                    
                    VStack(spacing: 7) {
                        
                        CustomTextFieldSignUp(image: "user", placeHolder: "First Name", text: $model.FirstNameSignUp)
                        
                        CustomTextFieldSignUp(image: "message", placeHolder: "Email", text: $model.emailSignUp)
                        
                        CustomTextFieldSignUp(image: "lock", placeHolder: "Password", text: $model.passwordSignUp)
                    }
                    .padding(.bottom)
                    
                    //Special information buttons...
                    
                    VStack {
                        SigInButton(image: "Vector1", text: "Keep me signed in", isSystem: true) {
                        }
                        
                        SigInButton(image: "Vector1", text: "Email me about special pricing and more", isSystem: true) {
                            
                        }
                    }
                    
                    // Create Account Button...
                    Spacer(minLength: 0)
                    VStack {
                        
                        Button(action: model.signUp) {
                            Text("Create Account")
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: 0x573353))
                                .padding(.horizontal)
                                .frame(width: UIScreen.main.bounds.width - 20,height: 55)
                                .background(Color(hex: 0xFDA758))
                                .cornerRadius(10)
                        }
                        .padding(.top,6)
                        
                        
                        Text("Or sign in with")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.top,5)
                        Divider()
                        
                    }
                    
                    // Other Sign in ...
                    
                    HStack {
                        LogInButtons(image: "Google", text: "Google", isSystem: true) {
                        }
                        .padding(.leading,10)
                        
                        LogInButtons(image: "Facebook", text: "Facebook", isSystem: true) {
                        }
                        .padding(.trailing,10)
                    }
                    Spacer(minLength: 0)

                    // Come Back to log in...
                    
                    HStack() {
                        Text("Already have an account?")
                        Button(action: {model.isSignUp.toggle()}) {
                            Text("Log in")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }
                    }
                    Spacer(minLength: 0)
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color(hex: 0xFFF3E9))
            .ignoresSafeArea()
            
            if model.isLoading {
                LoadingView()
            }
        }
        
        //Alert....
        .alert(isPresented: $model.alert) {
            Alert(title: Text("Message"),message: Text(model.alertMassage),
                  dismissButton: .destructive(Text("ok"),action: {
                
                // if email link sent means closing the signupView...
                
                if model.alertMassage == "Email Verification Has Been Sent !!! Verify Your Email ID !" {
                    model.isSignUp.toggle()
                    model.FirstNameSignUp = ""
                    model.emailSignUp = ""
                    model.passwordSignUp = ""
                }
            }))
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct CustomTextFieldSignUp: View {
    
    var image: String
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            ZStack {
                if placeHolder == "Password" {
                    SecureField(placeHolder,text: $text)
                } else {
                    TextField(placeHolder,text: $text)
                }
            }
            .padding(.horizontal)
            .padding(.leading, 65)
            .frame(height: 55)
            .background(Color.white)
            .cornerRadius(10)
            
            Image(image)
                .font(.system(size: 24))
                .frame(width: 60, height: 50)
                .background(Color.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct SigInButton: View {
    
    var image: String
    var text: String
    var isSystem: Bool
    
    var onClick: ()->()
    
    var body: some View {
        
        HStack {
            (
                isSystem ? Image(image) : Image("")
            )
            .aspectRatio(contentMode: .fill)
            .frame(width: 20, height: 20)
            .padding(.horizontal,1)
            .background(Color(hex: 0xFDA758))
            .cornerRadius(5)
            
            Text(text)
                .font(.system(size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor( isSystem ? .init(hex: 0x573353) : .black )
        .padding(.horizontal, 30)
        .onTapGesture {
            onClick()
        }
    }
}

struct LogInButtons: View {
    
    var image: String
    var text: String
    var isSystem: Bool
    
    var onClick: ()->()
    
    var body: some View {
        
        HStack {
            (
                isSystem ? Image(image) : Image(image)
            )
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 25, height: 10)
            .padding(.horizontal,5)
            
            Text(text)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor( isSystem ? .init(hex: 0x573353) : .black )
        .padding(.vertical, 17)
        .padding(.horizontal,25)
        .background(
            .white.opacity( isSystem ? 1 : 0.5)
        )
        .cornerRadius(10)
        .onTapGesture {
            onClick()
        }
    }
}
