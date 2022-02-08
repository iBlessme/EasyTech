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
    
    
    func addOrder(imageOrder: UIImage, housing: String, floor: Int, description: String, hall: String){
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: +3)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: time as Date)
        let dateNow = "\(formatteddate)"
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Int.random(in: 1..<999999)
        Firestore.firestore().collection("orders").document(String(ref)).setData([
       
//            "imageOrder" : imageOrder,
            "housing" : housing,
            "floor" : floor,
            "description" : description,
            "hall" : hall,
            "status" : "Не взят",
            "dateRegistration": dateNow,
            "idClient" : uid
        
        ]){err in
            if err != nil{
                print("Не получилось создать заявку")
                return
            }else{
                print("Документ создан")
                let ref = Storage.storage().reference().child("orders").child(String(ref))
                
                guard let imageData = imageOrder.jpegData(compressionQuality: 0.4) else {return}
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
                        print(downloadUrl)
                        print("Success upload image")
                        
                    }
                }
            }
            
            
        }
                
    }
//    private func imageToStorage(image: UIImage?, refI: URL){
//         let ref = Storage.storage().reference().child("orders").child(refI)
//
//         guard let imageData = image?.jpegData(compressionQuality: 0.4) else {return}
//         let metadata = StorageMetadata()
//         metadata.contentType = "image/jpeg"
//
//         _ = ref.putData(imageData, metadata: metadata) {metadata, error in
//             if let error = error{
//                 print("Failed image 1 \(error)")
//             }
//             guard let metadata = metadata else {return}
//             _ = metadata.size
//             ref.downloadURL{ url, error in
//                 guard let downloadUrl = url else {return}
//                 print("Success upload image")
//             }
//         }
//     }
    
}
