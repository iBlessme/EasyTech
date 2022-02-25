//
//  OrdersUserView.swift
//  EasyTech
//
//  Created by iBlessme on 08.02.2022.
//

import SwiftUI
import SDWebImageSwiftUI



struct OrdersUserView: View {
    @ObservedObject var ordersUser = GetOrderToUSer()
    @State var showAlertToDelete = false
    @State var refOrder = ""
    @State var update = false
    @State var isComplete = false
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
            Picker(selection: $isComplete, label: Text("Статус")){
                Text("Активные")
                    .tag(false)
                    .foregroundColor(Color.purple)
                Text("Закрытые")
                    .tag(true)
                    .foregroundColor(Color.purple)
            }
            .pickerStyle(.menu)
            
            }
            
        ScrollView{
            ForEach(ordersUser.orderList){ orders in
                
                if orders.status == "Завершен" && isComplete == true{
                    VStack(alignment: .leading){
                        
                        
                        ZStack {
                            WebImage(url: URL(string: orders.imageOrder))
                                .resizable()
                                .scaledToFill()
                                .frame(height: 300)
                                .clipped()
        //                        .cornerRadius(20)
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(.label), lineWidth: 0))
                            .shadow(radius: 5)
                            VStack {
                                HStack {

                                    Text("\(orders.status)")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color.white)
                                        .shadow(color: Color.black, radius: 3, x: 1, y: 1)
                                    Spacer()
                                    Button{
                                        self.showAlertToDelete.toggle()
                                        self.refOrder = orders.id
                                    }label: {
                                        Image(systemName: "trash.fill")
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color.white)
                                            .shadow(color: Color.black, radius: 3, x: 1, y: 1)
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                           
                            VStack{
                                Spacer()
                            HStack {
                                Text("\(orders.dateRegistration)")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 15, weight: .bold))
                                    .shadow(color: Color.black, radius: 5, x: 1, y: 1)
                                Spacer()
                                }
                            }
                            .padding()
                        }
    //                        .padding()
                        VStack(alignment: .leading){
                            HStack {
                                Text("Корпус: \(orders.housing)")
                                Spacer()
                                Text("Этаж: \(orders.floor)")
                            }
                            Divider()
                            HStack{
                                Text("Кабинет: \(orders.hall)")
                                Spacer()
                                
                            }
                            Divider()
                            .padding(.vertical, 2)
                            Text("Описание: \(orders.description)")
                           
                            
                        }
                        .font(.system(size: 15, weight: .bold))
                        .padding()
                        .foregroundColor(Color.white)
                        
                    }
                    
                    .background(Color(.init(white: 0, alpha: 0.2)))
                    .background(Color.purple)
                    .cornerRadius(20)
                }
                else if orders.status != "Завершен" && isComplete == false{
                    VStack(alignment: .leading){
                        
                        
                        ZStack {
                            WebImage(url: URL(string: orders.imageOrder))
                                .resizable()
                                .scaledToFill()
                                .frame(height: 300)
                                .clipped()
        //                        .cornerRadius(20)
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(.label), lineWidth: 0))
                            .shadow(radius: 5)
                            VStack {
                                HStack {

                                    Text("\(orders.status)")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color.white)
                                        .shadow(color: Color.black, radius: 3, x: 1, y: 1)
                                    Spacer()
                                    Button{
                                        self.showAlertToDelete.toggle()
                                        self.refOrder = orders.id
                                    }label: {
                                        Image(systemName: "trash.fill")
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color.white)
                                            .shadow(color: Color.black, radius: 3, x: 1, y: 1)
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                           
                            VStack{
                                Spacer()
                            HStack {
                                Text("\(orders.dateRegistration)")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 15, weight: .bold))
                                    .shadow(color: Color.black, radius: 5, x: 1, y: 1)
                                Spacer()
                                }
                            }
                            .padding()
                        }
    //                        .padding()
                        VStack(alignment: .leading){
                            HStack {
                                Text("Корпус: \(orders.housing)")
                                Spacer()
                                Text("Этаж: \(orders.floor)")
                            }
                            Divider()
                            HStack{
                                Text("Кабинет: \(orders.hall)")
                                Spacer()
                                
                            }
                            Divider()
                            .padding(.vertical, 2)
                            Text("Описание: \(orders.description)")
                           
                            
                        }
                        .font(.system(size: 15, weight: .bold))
                        .padding()
                        .foregroundColor(Color.white)
                        
                    }
                    
                    .background(Color(.init(white: 0, alpha: 0.2)))
                    .background(Color.purple)
                    .cornerRadius(20)
                }
                else{
                    
                }
                
                
                
            }
        }
            
            
                       
            }
        .shadow(radius: 5)
        .alert("Вы действительно хотите удалить заявку?",isPresented: $showAlertToDelete){
            Button("Да"){
                DeleteOrder().deleteOrder(ref: self.refOrder)
            }
            Button{
                self.showAlertToDelete = false
            }label: {
                Text("Отмена")
                    .foregroundColor(Color.red)
            }
            
        
        }
    }
        
    }

struct OrdersUserView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersUserView()
    }
}
