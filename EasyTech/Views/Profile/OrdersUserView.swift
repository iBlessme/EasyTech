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
    
    var body: some View {
        ScrollView{
            ForEach(ordersUser.orderList){ orders in
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
                        HStack {
                            Circle()
                                .foregroundColor(Color.green)
                            .frame(width: 15, height: 15)
                            Text("online")
                                .font(.system(size: 12))
                                .foregroundColor(Color(.lightGray))
                        }
                        VStack{
                            Spacer()
                        HStack {
                            Text("Jslsdal")
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
                            Text("Статус: \(orders.status)")
                        }
                        Divider()
                        HStack{
                            Text("Дата: \(orders.dateRegistration)")
                            Spacer()
                            Text("Завершено: \(orders.dateCompleted)")
                        }
                        Divider()
                        .padding(.vertical, 2)
                        Text("Описание: \(orders.description)")
                       
                        
                    }
                    .font(.system(size: 15, weight: .bold))
                    .padding()
                    .foregroundColor(Color.white)
                    
                }
                .background(Color(.init(white: 0, alpha: 0.3)))
                .background(Color.purple)
                .cornerRadius(20)
                
                
            }
            
             
            }
        
        
        }
        
    

struct OrdersUserView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersUserView()
    }
}
