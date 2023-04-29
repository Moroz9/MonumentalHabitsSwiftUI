//
//  ModelData.swift
//  MonumentalHabitsUI
//
//  Created by Viktor Morozov on 29.04.23.
//

import SwiftUI
import Firebase

class ModelData: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var isReserPassword = false
    @Published var FirstNameSignUp = ""
    @Published var emailSignUp = ""
    @Published var passwordSignUp = ""
    @Published var emailReset = ""
    
    // AlertView With TextFields...
    
    
    // Alert Error
    @Published var alert = false
    @Published var alertMassage = ""
    
    // User Status ...
    
    @AppStorage("LogStasus") var status = false
    
    //Loading...
    
    @Published var isLoading = false
    
    
    // Login...
    
     func login() {
        
        // checking all fields are inputted correctly...
        
        if email == "" || password == "" {
            self.alertMassage = "Fill the contents properly !"
            self.alert.toggle()
            return
        }
        
        withAnimation {
            self.isLoading.toggle()
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            
            withAnimation {
                self.isLoading.toggle()
            }
            
            if err != nil {
                self.alertMassage = err!.localizedDescription
                self.alert.toggle()
                return
            }
            // checking if user is verifed or not...
            // if not verified means lgging out...
            
            let user = Auth.auth().currentUser
            
            if !user!.isEmailVerified {
                
                self.alertMassage = "Please Verify Email Address!!!"
                self.alert.toggle()
                // logging out...
                try! Auth.auth().signOut()
                
                return
            }
            // setting user status as true...
            
            withAnimation {
                self.status = true
            }
        }
    }
    
    //SignUp...
    
    func signUp() {
        
        //checking ...
        if FirstNameSignUp == "" || emailSignUp == "" || passwordSignUp == "" {
            self.alertMassage = "Fill contents the properly !"
            self.alert.toggle()
            return
        }
        withAnimation {
            self.isLoading.toggle()
        }
        Auth.auth().createUser(withEmail: emailSignUp, password: passwordSignUp) { result, err in
            withAnimation {
                self.isLoading.toggle()
            }
            
            if err != nil {
                self.alertMassage = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            //sending Verefcation Link ...
            
            result?.user.sendEmailVerification(completion: { err in
                if err != nil {
                    self.alertMassage = err!.localizedDescription
                    self.alert.toggle()
                    return
                }

                //Alerting User to Verify Email..
                
                self.alertMassage = "Email Verification Has Been Sent !!! Verify Your Email ID !"
                self.alert.toggle()
            })
        }
    }

    //LogOut...
    
    func logOut() {
        
        try! Auth.auth().signOut()
        
        withAnimation {
            self.status =  false
        }
        //Clear data .....
        
        email = ""
        password = ""
        emailSignUp = ""
        passwordSignUp = ""
        FirstNameSignUp = ""
        
    }
    
    //Reset password
    
    func resetPassword() {
        //checking ...
        if emailReset == "" {
            self.alertMassage = "Fill email !"
            self.alert.toggle()
            return
        }
        withAnimation {
            self.isLoading.toggle()
        }
        Auth.auth().sendPasswordReset(withEmail: emailReset) {(err) in
            withAnimation {
                self.isLoading.toggle()
            }
            
            if err != nil {
                self.alertMassage = err!.localizedDescription
                self.alert.toggle()
                return
            }
                //Alerting User..
                
                self.alertMassage = "Password Reset Link Has Been Sent !"
                self.alert.toggle()
            }
        }
    }

// Checking With Smaller Devices.



