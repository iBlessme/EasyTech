//
//  GetOrderToPerson.swift
//  EasyTech
//
//  Created by iBlessme on 10.02.2022.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class GetOrderToPerson: ObservableObject{
    
//    @Published var ordrModel: [Order] = []
    
    func getOrderToPerson(id: String){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").getDocuments{
            users, err in
            if err != nil{
                print("Не удалось получить пользователей")
                return
            }
            for document in users!.documents{
                document.reference.collection("orders").document(id).updateData([
                    "idPerson" : uid,
                    "status" : "В работе"
                ]){ err in
                    if err != nil {
                        print("Не удалось привязать данные")
                    }
                    else{
                        print("Документ успешно привязан")
                    }
                }
               
            }
        }
        
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        Firestore.firestore().collection("users").document(uid).collection("orders").document(id).updateData([
//            "idPerson" : uid,
//            "status" : "Выполняется"
//        ]){
//            err in
//            if err != nil{
//                print("Не удалось привязать заказ")
//                return
//            }
//            else{
//                print("Заказ успешно привязан")
//            }
//        }
//
        
        
    }
    
}
