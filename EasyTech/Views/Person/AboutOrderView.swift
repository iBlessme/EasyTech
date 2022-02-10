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
//                        .foregroundColor(Color.w)
                        .shadow(radius: 10)
                        .font(Font.system(size: 15, weight: .bold))
                        .padding(3)
                        Button{
                            print("Succes")
                            self.checkPosition()
                            if self.isSuccesToJob{
                                GetOrderToPerson().getOrderToPerson(id: id)
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
                    
                    Spacer()
                }
                
                Spacer()
            }
        }.background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
        
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
        AboutOrderView(id: .constant(""), imageOrder: .constant(""), housing: .constant(""), floor: .constant(""), description: .constant(""), hall: .constant(""), status: .constant(""), dateRegistration: .constant(""), dateCompleted: .constant(""), idClient: .constant(""), idPerson: .constant(""), userosition: .constant(""))
    }
    
}
