//
//  AboutOrderAdmin.swift
//  EasyTech
//
//  Created by iBlessme on 02.03.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore

struct AboutOrderAdmin: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var id: String
    @Binding var imageOrder: String
    @Binding var housing: String
    @Binding var floor: String
    @Binding var description: String
    @Binding var hall: String
    @Binding var status: String
    @Binding var dateRegistration: String
    @Binding var dateCompleted: String
    @Binding var idClient: String
    @Binding var idPerson: String
    @Binding var userosition: String
    @Binding var phoneNumber: String
    @Binding var namePerson: String
    @Binding var surnamePerson: String
    @State var isSuccesToJob = false
    @State var isShowAlrtToErrorJob = false
    @State var isShowPersons = false
    @State var idOrder = ""
    @State var clientID = ""
    @State var showErrorMessage = false
   
    
    @ObservedObject var personOrder = UserModel()
    
    
    
    var body: some View {
        ScrollView{
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        if status != "В ожидании сотрудника"{
                           
                                Text("Сотрудник: \(namePerson) \(surnamePerson)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color.purple)
                        }
                        WebImage(url: URL(string: imageOrder))
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                            .cornerRadius(20)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(.label), lineWidth: 0))
                        .shadow(radius: 5)
                        .padding(5)
                        .shadow(radius: 10)
                        .font(Font.system(size: 15, weight: .bold))
                    Text("Описание: \(description)")
                        .shadow(radius: 10)
                        .font(Font.system(size: 15, weight: .bold))
                    Divider()
                        Group{
                            HStack{
                                
                            Text("Статус: \(status)")
                                Spacer()
                                
                            }
                            HStack{
                                Text("Корпус: \(housing)")
                                Spacer()
                                
                            }
                            HStack{
                                Text("Этаж: \(floor)")
                                Spacer()
                                Text("Кабинет: \(hall)")
                            }
                            HStack{
                                Text("Дата: \(dateRegistration)")
                                Spacer()
                                
                            }
                            HStack{
                                Text("Завершен: \(dateCompleted)")
                                Spacer()
                            }
                            if status == "В ожидании сотрудника"{
                                Button{
                                    self.idOrder = id
                                    self.clientID = idClient
                                    self.isShowPersons.toggle()
                                }label: {
                                    HStack {
                                        Spacer()
                                        Text("Назначить сотрудника")
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
                        .shadow(radius: 10)
                        .font(Font.system(size: 15, weight: .bold))
                        .padding(3)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
        .sheet(isPresented: $isShowPersons){
            AppointPerson(idOrder: $idOrder, idClitn: $idClient)
        }
        .alert("Заявка завершена", isPresented: $showErrorMessage){
            Button("ОК", role: .cancel) {}
        }
        .toolbar{
            Button{
                if status != "Завершен"{
                self.idOrder = id
                self.clientID = idClient
                self.isShowPersons.toggle()
                }else{
                    self.showErrorMessage.toggle()
                }
                
            }label: {
                Image(systemName: "pencil")
                    .foregroundColor(Color.purple)
                    .shadow(radius: 5)
                    .frame(width: 20, height: 20)
            }
        }
    }
        
        
    
}

struct AboutOrderAdmin_Previews: PreviewProvider {
    static var previews: some View {
        AboutOrderAdmin(id: .constant(""), imageOrder: .constant(""), housing: .constant(""), floor: .constant(""), description: .constant(""), hall: .constant(""), status: .constant(""), dateRegistration: .constant(""), dateCompleted: .constant(""), idClient: .constant(""), idPerson: .constant(""), userosition: .constant(""), phoneNumber: .constant(""), namePerson: .constant(""), surnamePerson: .constant(""))
    }
}
