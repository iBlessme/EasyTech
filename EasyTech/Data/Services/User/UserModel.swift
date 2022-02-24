//
//  UserModel.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit

class UserModel: ObservableObject{
    
    @Published var chatUser = [User]()
    @Published var userModel: User?
    @Published var isUserCurrentLogOut = false
    
    init(){
        fetchCurrentUser()
        fetchAllUser()
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
                
            self.userModel = User(id: uid, email: email, name: name, surname: surname, numberPhone: numberPhone, imageUrl: imageURL, permission: permission)
            
        }
    }
    
    private func fetchAllUser(){
        guard let id = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").getDocuments{
            users, error in
            if error != nil{
                print("Не удалось загрузить список пользователей")
                return
            }
            users?.documents.forEach({
                snapshot in
                let uid = snapshot["uid"] as? String ?? ""
                let email = snapshot["email"] as? String ?? ""
                let name = snapshot["name"] as? String ?? ""
                let surname = snapshot["surname"] as? String ?? ""
                let numberPhone = snapshot["numberPhone"] as? String ?? ""
                let permission = snapshot["permission"] as? String ?? ""
                let imageURL = snapshot["profileImageUrl"] as? String ?? ""
                
                if uid != id{
                    if permission != "4"{
                    let users = User(id: uid, email: email, name: name, surname: surname, numberPhone: numberPhone, imageUrl: imageURL, permission: permission)
                    self.chatUser.append(users)
                    print(users)
                    }
                }
                
            })
        }
    }
    
    func handleSignOut(){
        isUserCurrentLogOut.toggle()
        try? Auth.auth().signOut()
        
    }
    
    func checkPickPhoto(name: String, surname: String, phoneNumber: String, imageURL: UIImage, isPicker: Bool){
        if isPicker{
            self.updateImageProfile(name: name, surname: surname, phoneNumber: phoneNumber, imageURL: imageURL)
        }
        else{
            self.updateDataWithoutImage(name: name, surname: surname, phoneNumber: phoneNumber)
        }
    }
    
    func updateDataWithoutImage(name: String, surname: String, phoneNumber: String){
        guard let uid = Auth.auth().currentUser?.uid else {return}
         Firestore.firestore().collection("users").document(uid).updateData([
            "name": name,
            "surname" : surname,
            "numberPhone" : phoneNumber,
         ]){err in
             if err != nil{
                 print("Не удалось перезаписать данные")
                 return
             }
             print("Success Update Info User")
         }
    }
    
    
    func updateImageProfile(name: String, surname: String, phoneNumber: String, imageURL: UIImage){
        
        let user = Auth.auth().currentUser
        let uid = user!.uid
        let ref = Storage.storage().reference().child("users").child(uid)
        
        guard let imageData = imageURL.jpegData(compressionQuality: 0.4) else {return}
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = ref.putData(imageData, metadata: metadata) {metadata, error in
            if let error = error{
                print("Failed image 1 \(error)")
            }
            guard let metadata = metadata else {return}
            _ = metadata.size
            ref.downloadURL{ url, error in
                guard let downloadUrl = url else {return}
                self.updateStoreInformation(name: name, surname: surname, phoneNumber: phoneNumber, imageURL: downloadUrl)
                print("Success upload image")
            }
        }
        
        
        
    }
    
    func updateStoreInformation(name: String, surname: String, phoneNumber: String, imageURL: URL){
        guard let uid = Auth.auth().currentUser?.uid else {return}
         Firestore.firestore().collection("users").document(uid).updateData([
            "name": name,
            "surname" : surname,
            "numberPhone" : phoneNumber,
            "profileImageUrl" : imageURL.absoluteString
         ]){err in
             if err != nil{
                 print("Не удалось перезаписать данные")
                 return
             }
             print("Success Update Info User")
         }
        
    }
    func reload(){
        self.fetchCurrentUser()
    }
    
    
}
