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
        Firestore.firestore().collection("users").document(uid).collection("orders").document(id).setData([
            "idPerson" : uid,
            "status" : "Выполняется"
        ]){
            err in
            if err != nil{
                print("Не удалось привязать заказ")
                return
            }
            else{
                print("Заказ успешно привязан")
            }
        }
        
        
        
    }
    
}
