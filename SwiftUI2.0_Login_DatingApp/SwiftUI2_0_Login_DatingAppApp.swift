//
//  SwiftUI2_0_Login_DatingAppApp.swift
//  SwiftUI2.0_Login_DatingApp
//
//  Created by Jimmy Leu on 1/25/21.
//

import SwiftUI
import Firebase

@main
struct SwiftUI2_0_Login_DatingAppApp: App {
    
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


// Connecting FIrebase...
class Delegate : NSObject,UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
