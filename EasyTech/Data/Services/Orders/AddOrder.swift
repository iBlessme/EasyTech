//
//  AddOrder.swift
//  EasyTech
//
//  Created by iBlessme on 08.02.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import UIKit

class AddOrder{
    func imageToStorage(imageOrder: UIImage, housing: String, floor: Int, description: String, hall: String){
        
        let ref = Int.random(in: 1..<999999)
        
//        let uid = Auth.auth().currentUser?.uid
        let refI = Storage.storage().reference().child("orders")
            .child(String(ref))
        guard let imageData = imageOrder.jpegData(compressionQuality: 0.4) else {return}
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = refI.putData(imageData, metadata: metadata){
            metadata, error in
            if let error = error{
                print("Failed pu Image \(error)")
            }
            guard let metadata = metadata else {return}
            _ = metadata.size
            refI.downloadURL{
                url, error in
                guard let downloadUrl = url else {return}
                self.storeOrderInfo(imageOrder: downloadUrl, housing: housing, floor: floor, description: description, hall: hall, ref: String(ref))
                print("Succes download Image")
            }
        }
    }
    
    func storeOrderInfo(imageOrder: URL, housing: String, floor: Int, description: String, hall: String, ref: String){
        
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: +3)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: time as Date)
        let dateNow = "\(formatteddate)"
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("users").document(uid).collection("orders").document(ref).setData([
            "imageOrder" : imageOrder.absoluteString,
            "housing" : housing,
            "floor" : String(floor),
            "description" : description,
            "hall" : hall,
            "status" : "В ожидании сотрудника",
            "dateRegistration": dateNow,
            "idClient" : uid
        ]){
            err in
            if err != nil{
                print("Не получилось создать заявку")
                return
            }else{
                print("Документ создан")
            
        }
        
    }
    }
}
