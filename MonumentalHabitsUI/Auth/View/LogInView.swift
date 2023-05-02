//
//  ContentView.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 27.04.23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @AppStorage("LogStatus") var status = false
    @StateObject var model = ModelData()
    
    var body: some View {
        
        ZStack {
            if status {
                VStack(spacing: 25) {
                    Text("Logged In As \(Auth.auth().currentUser?.email ?? "" )")
                    
                    Button(action: model.logOut) {
                        
                        Text("LogOut")
                            .fontWeight(.bold)
                    }
                }
            }
            else {
                LogInView(model: model)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LogInView: View {
    
    @ObservedObject var model : ModelData
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    ZStack {
                        
                        // background image...
                        
                        GeometryReader { proxy in

                            Image("bagroundImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)

                            Image("Rectangle 23867")
                                .resizable()
                        }
                        .ignoresSafeArea()
                        
                        // View stack...
                        
                        VStack {
                            Spacer()
                            
                            // Text Welcome...
                            
                            VStack {
                                Text("WELCOME TO")
                                    .padding(.top)
                                    .font(.system(size: 30))
                                    .font(.largeTitle.bold())
                                
                                Text("MONUMENTAL HABITS")
                                    .font(.system(size: 30))
                                    .font(.largeTitle.bold())
                            }
                            //Button continue with...
                            
                            VStack {
                                LogInButton(image: "Google", text: "Continue with Google", isSystem: true) {
                                }
                                LogInButton(image: "Facebook", text: "Continue with FaceBook", isSystem: true) {
                                }
                            }
                            
                            // Log in with email...
                            
                                VStack(spacing: 10) {

                                    Text("Log in with email")
                                        .font(.system(size: 16))
                                        .padding(.top,10)
                                    Divider()

                                        CustomTextField(image: "message", placeHolder: "Email", text: $model.email)

                                        CustomTextField(image: "lock", placeHolder: "Password", text: $model.password)
                     
                                    Button(action: model.login) {
                                        Text("Login")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .frame(width: UIScreen.main.bounds.width - 20,height: 55)
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
                                    .padding(.top,5)
                                    .padding(.bottom,30)
                                    
                                }
                                .padding(.horizontal)
                                .padding(.bottom,10)
                                .background(.white)
                                .cornerRadius(30)
                        }
                       
                        .padding(.bottom,-34)
                    }
                    
                    // Icons Answer...
                    
                    Button(action: {}) {
                        Image("Icons")
                            .padding(.vertical,-10)
                            .padding(.horizontal)
                    }
                    .padding(.trailing)
                }
            }
            
            if model.isLoading {
                LoadingView()
            }
        }
        .fullScreenCover(isPresented: $model.isSignUp) {
            SignUpView(model: model)
        }
        .fullScreenCover(isPresented: $model.isReserPassword) {
            ResetPasswordView(model: model)
        }
        // Alerts...
        .alert(isPresented: $model.alert) {
            Alert(title: Text("Message"),message: Text(model.alertMassage),dismissButton: .destructive(Text("ok")))
        }
    }
}

// LogInButton...

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

// CustomTextField...

struct CustomTextField: View {
    
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

// Loading View...

struct LoadingView: View {
    
    @State var animation = false
    
    var body: some View {
        
        VStack {
            Circle()
                .trim(from: 0,to: 0.7)
                .stroke(Color.gray,lineWidth: 8)
                .frame(width: 75,height: 75)
                .rotationEffect(.init(degrees: animation ? 360 : 0))
                .padding(50)
        }
        .background(Color.black)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5).ignoresSafeArea(.all,edges: .all))
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 1)) {
                animation.toggle()
            }
        })
    }
}
