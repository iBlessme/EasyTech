//
//  DeleteOrder.swift
//  EasyTech
//
//  Created by iBlessme on 09.02.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class DeleteOrder{
    
    func deleteOrder(ref: String){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).collection("orders").document(ref).delete(){
            err in
            if err != nil{
                print("Не удалось удалить заявку")
            }
            else{
                print("Документ успешно удален")
                self.deleteImageOrder(ref: ref)
            }
        }
    }
    
    func deleteImageOrder(ref: String){
        let refI = Storage.storage().reference().child("orders").child(ref)
        
        refI.delete{
            err in
            if err != nil{
                print("Не удалось удалить изображение заказа")
            }
            else{
                print("Изображение успешно удалено")
            }
        }
    }
    
}
