//
//  ModelData.swift
//  SwiftUI2.0_Login_DatingApp
//
//  Created by Jimmy Leu on 1/27/21.
//

import Foundation
import SwiftUI
import Combine
class ModelData: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var email_SignUp = ""
    @Published var passowrd_SignUp = ""
    @Published var reEngerPassword = ""
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
            
            self.resetEmail = alert.textFields![0].text!
            // Preseing  alert when email link has been sent ...
            self.isLinkSend.toggle()
        }
        
        let cancel = UIAlertAction(title:"Cancel", style:.destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        // presenting
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated:true)
    }
    
}
