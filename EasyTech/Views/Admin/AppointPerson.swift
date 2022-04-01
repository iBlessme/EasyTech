//
//  AppointPerson.swift
//  EasyTech
//
//  Created by iBlessme on 02.03.2022.
//

import SwiftUI

struct AppointPerson: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var usersChat = UserModel()
    @State var idPerson = ""
    @Binding var idOrder: String
    @Binding var idClitn: String
    @State var namePerson = ""
    
    
    var body: some View {
        
        VStack{
            Text("Выберите сотрудника")
                .font(.system(size: 30, weight: .bold))
                .padding()
            Spacer()
            Picker(selection: $idPerson, label: Text("Сотрудник")){
                ForEach(usersChat.chatUser, id: \.self){ user in
                    Text("\(user.name) \(user.surname)")
                        .tag(user.id)
                }
            }
            .pickerStyle(.inline)
            Spacer()
            Button{
//                print(idPerson)
//                print(idOrder)
                    GetOrderToPerson().getOrderToPersonAdmin(id: idPerson, documentId: idOrder, idClient: idClitn)
                    presentationMode.wrappedValue.dismiss()
                
            }label: {
                HStack {
                    Spacer()
                    Text("Сохранить")
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                    }
                .foregroundColor(Color.white)
                .padding(.vertical)
                .background(Color.purple)
                .cornerRadius(32)
                .padding(.horizontal)
                .shadow(radius: 15)
                }
            .padding(.top, 10)
            }
    }
}

struct AppointPerson_Previews: PreviewProvider {
    static var previews: some View {
        AppointPerson(idOrder: .constant(""), idClitn: .constant(""))
    }
}
