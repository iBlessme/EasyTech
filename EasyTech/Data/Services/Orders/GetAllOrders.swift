//
//  GetAllOrders.swift
//  EasyTech
//
//  Created by iBlessme on 10.02.2022.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class GetAllOrders: ObservableObject{
    
    @Published var allOrders = [Order]()
    @Published var count = 0
    @Published var countWaitPerson = 0
    @Published var countInWork = 0
    @Published var countCompleted = 0
    @Published var chartAllTime = []
    init(){
        fetchAllOrder()
    }
    
    func fetchAllOrder(){
        
        Firestore.firestore().collection("users").getDocuments{ users, err in
            if err != nil{
                print("Не уадлось получить пользователей")
                return
                }
            for document in users!.documents{
                document.reference.collection("orders").order(by: "dateRegistration").getDocuments{
                    snapshots, err in
                    if err != nil{
                        print("Fatal")
                        return
                    }
                    snapshots?.documents.forEach({snapshot in
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
                                    self.allOrders.append(order)
                                    print(order)
                        DispatchQueue.main.async {
                            self.count += 1
                            if status == "В ожидании сотрудника"{
                                self.countWaitPerson += 1
                            }
                            else if status == "В работе"{
                                self.countInWork += 1
                            }
                            else{
                                self.countCompleted += 1
                            }
                        }
//                        self.count += 1
                    })
                    
                }
                
            }
        }
    }
    func reload() async{
        self.allOrders.removeAll()
        self.fetchAllOrder()
    }
}
