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
    var namePerson = ""
    var surnamePerson = ""
    
    func getOrderToPerson(id: String, namePerson: String, surnamePerson: String){
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
                    "status" : "В работе",
                    "namePerson" : namePerson,
                    "surnamePerson" : surnamePerson
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
    }
    
    func getOrderToPersonAdmin(id: String, documentId: String, idClient: String){
        
        Firestore.firestore().collection("users").document(id)
            .addSnapshotListener{
                snapshot, err in
                if err != nil{
                    print("Не удалось загрузить пользователя")
                    return
                }
                guard let data = snapshot?.data() else {return}
                print(data)
                let name = data["name"] as? String ?? ""
                let surname = data["surname"] as? String ?? ""
                
                self.namePerson = name
                self.surnamePerson = surname
                print(self.namePerson)
                print(self.surnamePerson)
                self.updateOrder(id: id, documentID: documentId, idClient: idClient)
               
            }
    }
    
    func updateOrder(id: String, documentID: String, idClient: String){
        Firestore.firestore().collection("users").document(idClient).collection("orders").document(documentID).updateData([
        
            "idPerson" : id,
            "status" : "В работе",
            "namePerson" : self.namePerson,
            "surnamePerson" : self.surnamePerson
        ]){err in
                if err != nil {
                    print("Не удалось привязать данные")
                    return
                }
                else{
                    print("Документ успешно привязан")
                }
        }
    }
    
    func clouseOrder(id: String){
        
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: +3)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: time as Date)
        let dateNow = "\(formatteddate)"
        
        Firestore.firestore().collection("users").getDocuments{
            users, err in
            if err != nil{
                print("Не удалось получить пользователей")
                return
            }
            for document in users!.documents{
                document.reference.collection("orders").document(id).updateData([
                    "status" : "Завершен",
                    "dateCompleted" : dateNow
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
    }
    
}
