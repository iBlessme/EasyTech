//
//  UserModel.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserModel: ObservableObject{
    
    @Published var userModel: User?
    @Published var isUserCurrentLogOut = false
    
    init(){
        fetchCurrentUser()
        DispatchQueue.main.async {
            self.isUserCurrentLogOut = Auth.auth().currentUser?.uid == nil
        }
    }
    
    private func fetchCurrentUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument{snapshot, error in
            if error != nil{
                print("Failed load user")
                return
            }
     
                guard let data = snapshot?.data() else {return}
                print(data)
                let uid = data["uid"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let surname = data["surname"] as? String ?? ""
                let numberPhone = data["numberPhone"] as? String ?? ""
                let permission = data["permission"] as? String ?? ""
                let imageURL = data["profileImageUrl"] as? String ?? ""
                
            self.userModel = User(uid: uid, email: email, name: name, surname: surname, numberPhone: numberPhone, imageUrl: imageURL, permission: permission)
            
        }
    }
    
    func handleSignOut(){
        isUserCurrentLogOut.toggle()
        try? Auth.auth().signOut()
    }
    
    
//    func loadPermission() -> Bool{
//        if UserModel().userModel?.permission == "4"{
//            print("\(UserModel().userModel?.permission)")
//            return true
//        }
//        else{
//            print("else")
//            print("\(UserModel().userModel?.name)")
//            return false
//        }
//    }
    
}
