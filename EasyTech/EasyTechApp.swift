//
//  EasyTechApp.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

@main
struct EasyTechApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            
            if Auth.auth().currentUser != nil{
                    MainUserView()
             
            }
            else{
                ContentView()
            }
        }
    }
}
