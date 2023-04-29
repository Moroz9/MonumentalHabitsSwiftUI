//
//  ContentView.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 27.04.23.
//

import SwiftUI

struct LogInView: View {
    
    @StateObject var model = ModelData()
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            
            ZStack {
                GeometryReader { proxy in
                    
                    Image("bagroundImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Image("Rectangle 23867")
                        .resizable()
                }
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("WELCOME TO")
                        .padding(.top)
                        .font(.system(size: 30))
                        .font(.largeTitle.bold())
                    Text("MONUMENTAL HABITS")
                        .font(.system(size: 30))
                        .font(.largeTitle.bold())
                    VStack {
                        LogInButton(image: "Google", text: "Continue with Google", isSystem: true) {
                        }
                        LogInButton(image: "Facebook", text: "Continue with FaceBook", isSystem: true) {
                        }
                        
                    }
                  
                        VStack(spacing: 10) {
                            Text("Log in with email")
                                .font(.system(size: 16))
                                .padding(.top)
                            Divider()
                            
                            VStack {
                                CustomTextField(image: "massege", plaseHolder: "Email", text: $model.email)
                                
                                CustomTextField(image: "lock", plaseHolder: "Password", text: $model.password)
                            }
                            .padding(.top)
                            
                            Button(action: {}) {
                                Text("Login")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .frame(width: UIScreen.main.bounds.width - 20,height: 60)
                                    .background(Color(hex: 0xFDA758))
                                    .cornerRadius(10)
                            }
                            .padding(.top, 10)
                            
                            Button(action: {model.isReserPassword.toggle()}) {
                                Text("Forgot Password?")
                                    .foregroundColor(.black)
                            }
                            .padding(.top, 10)
                            
                            HStack(spacing: 5) {
                                Text("Don’t have an account?")
                                
                                Button(action: { model.isSignUp.toggle()}) {
                                    Text("Sign up")
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(.bottom)
                            
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.top,10)
                    
                }
                .ignoresSafeArea()
            }
            
            Button(action: {}) {
                Image("Icons")
                    .padding(.vertical,-10)
                    .padding(.horizontal)
            }
            .padding(.trailing)
        }
        .fullScreenCover(isPresented: $model.isSignUp) {
            SignUpView(model: model)
        }
        .fullScreenCover(isPresented: $model.isReserPassword) {
            ResetPasswordView(model: model)
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}

struct LogInButton: View {
    
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
            .frame(width: 25, height: 25)
            .padding(.horizontal,30)
            
            Text(text)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor( isSystem ? .init(hex: 0x573353) : .black )
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .background(
            .white.opacity( isSystem ? 1 : 0.5)
        )
        .cornerRadius(10)
        .padding(.horizontal,15)
        .onTapGesture {
            onClick()
        }
    }
}

struct CustomTextField: View {
    
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
            .frame(height: 60)
            .background(Color(hex: 0xFFF6ED))
            .cornerRadius(10)
            
            Image(image)
                .font(.system(size: 24))
                .frame(width: 60, height: 60)
                .background(Color(hex: 0xFFF6ED))
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

///MVVM Model..

class ModelData: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var isReserPassword = false
    @Published var FirstNameSignUp = ""
    @Published var emailSignUp = ""
    @Published var passwordSignUp = ""
    
}
