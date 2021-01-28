//
//  ContentView.swift
//  SwiftUI2.0_Login_DatingApp
//
//  Created by Jimmy Leu on 1/25/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @AppStorage("login_Status") var status = false
    @StateObject var model = ModelData()
    var body: some View {
        
        ZStack{
            if status {
                VStack(spacing:25){
                    Text("Logged In As \(Auth.auth().currentUser?.email ?? "")")
                    
                    Button(action:{
                        model.signOut()
                    }){
                       Text("LogOut")
                        .fontWeight(.bold)
                    }
                }
                
            }else{
                LoginView()
            }
               
        }
        
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
