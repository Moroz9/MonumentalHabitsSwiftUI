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
            
            VStack() {
                Spacer(minLength: 0)
                
                ZStack {
                    if UIScreen.main.bounds.height < 750 {
                        Image("Create Your Account")
                            .resizable()
                            .frame(width: 130,height: 130)
                    } else {
                        Image("Create Your Account")
                    }
                }
                .padding(.horizontal)
                .padding(.vertical,20)
                .padding(.top)
                Text("CREATE YOUR ACCOUNT")
                Spacer()
                
                VStack(spacing: 7) {
                    
                    CustomTextFieldSignUp(image: "user", plaseHolder: "First Name", text: $model.FirstNameSignUp)
                    
                    CustomTextFieldSignUp(image: "massege", plaseHolder: "Email", text: $model.emailSignUp)
                    
                    CustomTextFieldSignUp(image: "lock", plaseHolder: "Password", text: $model.passwordSignUp)
                }
                
                VStack {
                    SigInButton(image: "Vector1", text: "Keep me signed in", isSystem: true) {
                    }
                    
                    SigInButton(image: "Vector1", text: "Email me about special pricing and more", isSystem: true) {
                    }
                    
                }
                
                VStack {
                    
                    Button(action: {}) {
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
              
                HStack {
                    LogInButtons(image: "Google", text: "Google", isSystem: true) {
                    }
                    
                    LogInButtons(image: "Facebook", text: "Facebook", isSystem: true) {
                    }
                }
                .padding()
                Spacer()
                
                HStack() {
                    Text("Already have an account?")
                    Button(action: {model.isSignUp.toggle()}) {
                        Text("Log in")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                .padding(.bottom,50)
            }
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color(hex: 0xFFF3E9))
        .ignoresSafeArea()
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct CustomTextFieldSignUp: View {
    
    var image: String
    var plaseHolder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            ZStack {
                if plaseHolder == "Password" {
                    SecureField(plaseHolder,text: $text)
                } else {
                    TextField(plaseHolder,text: $text)
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
