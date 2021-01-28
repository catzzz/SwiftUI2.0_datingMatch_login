//
//  ModelData.swift
//  SwiftUI2.0_Login_DatingApp
//
//  Created by Jimmy Leu on 1/27/21.
//

import Foundation
import SwiftUI
import Combine
import Firebase


class ModelData: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var email_SignUp = ""
    @Published var password_SignUp = ""
    @Published var reEnterPassword = ""
    @Published var resetEmail = ""
    @Published var isLinkSend = false
    
    
    // Error Alerts...
    @Published var alert = false
    @Published var alertMsg = ""
    
    // User status
    @AppStorage("login_Status") var status = false
    
    // Loading
    
    @Published var isLoading = false
    
    func resetPassword(){
        let alert = UIAlertController(title: "Reset Password", message: "Enter your Email to Reset Your Password", preferredStyle:.alert)
        
        alert.addTextField { (password) in
            password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { _ in
            withAnimation{
                
                self.isLoading.toggle()
            }
            if alert.textFields![0].text! != "" {
                withAnimation{
                    
                    self.isLoading.toggle()
                }
                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { (err) in
                    
                    withAnimation{
                        
                        self.isLoading.toggle()
                    }
                    
                    if err != nil{
                        self.alertMsg = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    // ALerting User...
                    self.alertMsg = "Password Reset Link Has Been Sent !!!"
                    self.alert.toggle()
                }
            }
//            self.resetEmail = alert.textFields![0].text!
//            // Preseing  alert when email link has been sent ...
//            self.isLinkSend.toggle()
        }
        
        let cancel = UIAlertAction(title:"Cancel", style:.destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        // presenting
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated:true)
    }
    
    
    // login
    
    func login(){
        // check all fiedls are inputed correctly
        if email == "" || password == "" {
            self.alertMsg = "Please fill the contents properly!!!"
            self.alert.toggle()
            return
        }
        
        withAnimation {
            self.isLoading.toggle()
        }
        
        Auth.auth().signIn(withEmail:email, password:password) { (result, err) in
            
            withAnimation{
                
                self.isLoading.toggle()
            }
            
            if err != nil {
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            // check if user is verifed or not
            // if not verified mean logout
            let user = Auth.auth().currentUser
            
            if !user!.isEmailVerified {
                self.alertMsg = "Please Verify Email Address!!!"
                self.alert.toggle()

                try! Auth.auth().signOut()

                return
            }
            
            // setting user status as true....
            
            withAnimation{
                
                self.status = true
            }
            
        }
        
        
        
        
        
        // setting user status as true
        
        withAnimation {
            
            self.status = true
        }
    }
    
    // signup
    
    func signUp(){
        // checking
        if email_SignUp == "" || password_SignUp == "" || reEnterPassword == "" {
            self.alertMsg = "Fill contents properly!!!"
            self.alert.toggle()
            return
        }
        
        if password_SignUp != reEnterPassword {
            self.alertMsg = "Password is not match!!!"
            self.alert.toggle()
            return
        }
        
        Auth.auth().createUser(withEmail: email_SignUp, password:password_SignUp) { (result, err) in
            
            if err != nil {
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            // sending verification Link
            
            self.alertMsg = "Email  Verification Has Been Sent!!! Verify Your email"
            self.alert.toggle()
            
            
        }
    }
    
    func signOut(){
        
        try! Auth.auth().signOut()
        
        withAnimation{
            
            self.status = false
        }
        
        // clearing all data...
        
        email = ""
        password = ""
        email_SignUp = ""
        password_SignUp = ""
        reEnterPassword = ""
    }
}
