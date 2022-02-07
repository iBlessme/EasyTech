//
//  Auth.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class Login{
    
    func loginUser(email: String, password: String){
        Auth.auth().signIn(withEmail: "\(email)@mpt.ru", password: password){response, error in
            if error != nil{
                print("ОшибОчка")
                return
            }
            print("Succes Auth")
        }
        
    }
//    func emailSearch(email: String){
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        let path = Firestore.firestore().collection("users").document(uid).getDocuments{snaphot in
//            
//            
//            
//        }
//    }
    
}
