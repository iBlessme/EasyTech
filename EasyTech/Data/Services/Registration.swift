//
//  Registration.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import UIKit
import FirebaseFirestore

class Registration{
    
    
    
    func regUser(email: String, password: String, image: UIImage,  name: String, surname: String, numberPhone: String){
        Auth.auth().createUser(withEmail: "\(email)@mpt.ru", password: password){
            result, error in
            if error != nil{
                print("failed")
                return
            }
            self.imageToStorage(image: image, email: email, password: password, name: name, surname: surname, numberPhone: numberPhone)
        }
    }
    
   private func imageToStorage(image: UIImage?, email: String, password: String, name: String, surname: String, numberPhone: String){
        let user = Auth.auth().currentUser
        let uid = user!.uid
        let ref = Storage.storage().reference().child("users").child(uid)
        
        guard let imageData = image?.jpegData(compressionQuality: 0.4) else {return}
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
                self.storeUserInformation(imageProfileUrl: downloadUrl, email: email, password: password, name: name, surname: surname, numberPhone: numberPhone)
                print("Success upload image")
            }
        }
    }
   private func storeUserInformation(imageProfileUrl: URL, email: String, password: String, name: String, surname: String, numberPhone: String){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userData = [
            "email": "\(email)@mpt.ru",
            "uid" : uid,
            "profileImageUrl": imageProfileUrl.absoluteString,
            "name" : name,
            "surname" : surname,
            "password" : password,
            "numberPhone" : numberPhone,
            "permission" : "4"
        ] as [String : Any]
        Firestore.firestore().collection("users")
            .document(uid).setData(userData){ err in
                if let err = err{
                    print(err)
//                    self.loginStatusMessage = "\(err)"
                    return
                }
                print("Success")
                
            }
    }
    
    
}
