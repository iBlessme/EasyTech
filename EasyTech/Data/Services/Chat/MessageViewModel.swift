//
//  MessageViewModel.swift
//  EasyTech
//
//  Created by iBlessme on 23.02.2022.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class MessageViewModel: ObservableObject{
    
    @Published var chatText = ""
    @Published var message = [Message]()
    
    func handleSend(toID: String, text: String){
        
        
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: +3)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: time as Date)
        let dateNow = "\(formatteddate)"
        
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let document = Firestore.firestore().collection("users").document(uid).collection("messages").document("messages").collection(toID).document()
        document.setData([
            "fromID" : uid,
            "toID" : toID,
            "text" : text,
            "timeStamp" : dateNow
        ]){
            err in
            if err != nil{
                print("Не удалось выгрузить сообщение")
                return
            }
            print("ссобщение успешно отправлено")
        }
        
        let forwardDocument = Firestore.firestore().collection("users").document(toID).collection("messages").document("messages").collection(uid).document()
        forwardDocument.setData([
            "fromID" : uid,
            "toID" : toID,
            "text" : text,
            "timeStamp" : dateNow
        ]){err in
            if err != nil{
                print("Не удалось перенаправить сообщение")
                return
            }
            print("Сообщение переадресовано")
        }
        
    }
    
    func fetchMessages(toID: String){
        guard let fromID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(fromID).collection("messages").document("messages")
            .collection(toID).getDocuments{
            querySnapshot, err in
            if err != nil{
                print("Не удалось загрузить данные")
                return
            }
            
            querySnapshot?.documents.forEach({snapshot in
                let id = snapshot.documentID
                let fromId = snapshot.get("fromID") as? String ?? "Не известен отправитель"
                let toId = snapshot.get("toID") as? String ?? "Не указан получатель"
                let text = snapshot.get("text") as? String ?? "Сообщение отсутствует"
                let timeStamp = snapshot.get("timeStamp") as? String ?? "Дата неизвестна"
                
                let messageList = Message(id: id, fromID: fromId, text: text, timStamp: timeStamp, toId: toId)
                
                self.message.append(messageList)
                print("Дошел")
                print(messageList)
                
            })
        }
        
    }
    
    
}
