//
//  AboutOrderView.swift
//  EasyTech
//
//  Created by iBlessme on 10.02.2022.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct AboutOrderView: View {
    
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
    
    
    var body: some View {
        
        ScrollView{
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    
                    VStack{
                        WebImage(url: URL(string: imageOrder))
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                            .cornerRadius(20)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(.label), lineWidth: 0))
                        .shadow(radius: 5)
                        Text("Номер заявки: \(id)")
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
                           
                        }
                        .shadow(radius: 10)
                        .font(Font.system(size: 15, weight: .bold))
                        .padding(3)
                        
                        
                        if status != "Завершен"{
                        if idPerson == Auth.auth().currentUser?.uid{
                            
                            Button{
                                presentationMode.wrappedValue.dismiss()
                                print("Clouse order")
                                self.checkPosition()
                                if self.isSuccesToJob{
                                    GetOrderToPerson().clouseOrder(id: id)
                                }
                                else{
                                    self.isShowAlrtToErrorJob.toggle()
                                }
                            }label: {
                                HStack {
                                    Spacer()
                                    Text("Завершить")
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
                        else{
                        Button{
                            presentationMode.wrappedValue.dismiss()
                            print("Succes")
                            self.checkPosition()
                            if self.isSuccesToJob{
                                GetOrderToPerson().getOrderToPerson(id: id, namePerson: namePerson, surnamePerson: surnamePerson)
                            }
                            else{
                                self.isShowAlrtToErrorJob.toggle()
                            }
                        }label: {
                            HStack {
                                Spacer()
                                Text("Взять в работу")
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
                        else{
                            HStack {
                                Spacer()
                                Text("Завершен")
                                    .font(.system(size: 16, weight: .bold))
                                Spacer()
                                }
                            .foregroundColor(Color.white)
                            .padding(.vertical)
                            .background(Color.gray)
                            .cornerRadius(32)
                            .padding(.horizontal)
                            .shadow(radius: 15)
                        }
                        
                        
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            
        }.background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
            .toolbar{
                Button{
                    if let url = URL(string: "tel://\(phoneNumber)"){
                        UIApplication.shared.openURL(url)
                    }
                }label: {
                    Image(systemName: "phone.fill")
                        .foregroundColor(Color.purple)
                        .shadow(radius: 5)
                }
            }
    }
        func checkPosition(){
            if userosition == "3"{
                self.isSuccesToJob = false
                print(false)
            }
            else if userosition == "2" || userosition == "1"{
                self.isSuccesToJob = true
                print(true)
            }
            else{
                print("else")
                return
                
            }
            
        }
}

struct AboutOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AboutOrderView(id: .constant(""), imageOrder: .constant(""), housing: .constant(""), floor: .constant(""), description: .constant(""), hall: .constant(""), status: .constant(""), dateRegistration: .constant(""), dateCompleted: .constant(""), idClient: .constant(""), idPerson: .constant(""), userosition: .constant(""), phoneNumber: .constant(""), namePerson: .constant(""), surnamePerson: .constant(""))
    }
    
}
