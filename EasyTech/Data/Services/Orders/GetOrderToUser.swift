//
//  GetOrderToUser.swift
//  EasyTech
//
//  Created by iBlessme on 09.02.2022.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class GetOrderToUSer: ObservableObject{
    
    @Published var orderList = [Order]()
    init(){
        fetchOrderToUser()
    }
    
    
    func fetchOrderToUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).collection("orders").order(by: "dateRegistration").getDocuments{querySnapshot, error in
            if error != nil{
                print("Failed Load Orders")
                return
            }
            querySnapshot?.documents.forEach({snapshot in
                
                let id = snapshot.documentID
                let housing = snapshot.get("housing") as? String ?? "Не указан"
                let floor = snapshot.get("floor") as? String ?? "Не указан"
                let description = snapshot.get("description") as? String ?? "Не указано"
                let hall = snapshot.get("hall") as? String ?? "Не указан"
                let status = snapshot.get("status") as? String ?? "Не известно"
                let dateRegistration = snapshot.get("dateRegistration") as? String ?? "отсутствует"
                let dateCompleted = snapshot.get("dateCompleted") as? String ?? "Нет"
                let idClient = snapshot.get("idClient") as? String ?? ""
                let idPerson = snapshot.get("idPerson") as? String ?? "Ожидание сотрудника"
                let imageOrder = snapshot.get("imageOrder") as? String ?? ""
                let numberPhone = snapshot.get("numberPhone") as? String ?? ""
                let namePerson = snapshot.get("namePerson") as? String ?? ""
                let surnamePerson = snapshot.get("surnamePerson") as? String ?? ""
                            
                let order = Order(id: id, imageOrder: imageOrder, housing: housing, floor: floor, description: description, hall: hall, status: status, dateRegistration: dateRegistration, dateCompleted: dateCompleted, idClient: idClient, idPerson: idPerson, numberPhone: numberPhone, namePerson: namePerson, surnamePerson: surnamePerson)
                
                self.orderList.append(order)
                print(order)
                
            })
          
        }
        }
    func reload(){
        self.orderList.removeAll()
        self.fetchOrderToUser()
    }
        
        
    }
    
