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
    @Published var count = 0
  
    
    init(){
        self.fetchMessages()
    }
    
   
    
    
    func handleSend(toID: String, text: String){
        
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: +3)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: time as Date)
        let dateNow = "\(formatteddate)"
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let document = Firestore.firestore().collection("users").document(uid).collection("messages").document()
        document.setData([
            "fromID" : uid,
            "toID" : toID,
            "text" : text,
            "timeStamp" : dateNow,
            "type": "text"
        ]){
            err in
            if err != nil{
                print("Не удалось выгрузить сообщение")
                return
            }
            print("ссобщение успешно отправлено")
            self.count += 1
            print(self.count)
        }
        
        let forwardDocument = Firestore.firestore().collection("users").document(toID).collection("messages").document()
        forwardDocument.setData([
            "fromID" : uid,
            "toID" : toID,
            "text" : text,
            "timeStamp" : dateNow,
            "type" : "text"
        ]){err in
            if err != nil{
                print("Не удалось перенаправить сообщение")
                return
            }
            print("Сообщение переадресовано")
        }
       
        
    }
    
    func fetchMessages(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).collection("messages").order(by: "timeStamp").addSnapshotListener{
            snapshots, err in
            if err != nil {
                print("Не удалось загрузить изображение")
                return
            }
            snapshots?.documents.forEach({
                snapshot in
                let id = snapshot.documentID
                let fromId = snapshot.get("fromID") as? String ?? "Не известен отправитель"
                let toId = snapshot.get("toID") as? String ?? "Не указан получатель"
                let text = snapshot.get("text") as? String ?? "Сообщение отсутствует"
                let timeStamp = snapshot.get("timeStamp") as? String ?? "Дата неизвестна"
                let type = snapshot.get("type") as? String ?? "Формат не известен"
                
                let messageList = Message(id: id, fromID: fromId, text: text, timStamp: timeStamp, toId: toId, type: type)
                
                self.message.append(messageList)
                print("Дошел")
                print(messageList)
                
            })
            DispatchQueue.main.async {
                self.count += 1
                print("second")
                print(self.count)
            }
        }
    }
    
    func reload() async{
        self.message.removeAll()
        self.fetchMessages()
    }
    
    
}
