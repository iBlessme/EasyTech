//
//  StatisticsAdmin.swift
//  EasyTech
//
//  Created by iBlessme on 02.03.2022.
//

import SwiftUI
import Charts

struct StatisticsAdmin: View {
    
    @State var isOfDay = true
    @State var showSheet = false
    
    @ObservedObject var allOrder = GetAllOrders()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Picker(selection: $isOfDay, label: Text("Статистика")){
                        Text("Полная статистика")
                            .tag(true)
                        Text("Статистика сотрудника")
                            .tag(false)
                    }
                    .pickerStyle(.segmented)
                    if isOfDay{
                        Divider()
                        Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1,0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1,0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1,0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
                                    .chartStyle(
                                        ColumnChartStyle(column: Capsule().foregroundColor(.purple), spacing: 3)
                                    )
                                    .frame(height: 200)
                        Divider()
                        Text("Всего заказов: \(allOrder.count)")
                            .font(.system(size: 30, weight: .bold))
                        Spacer()
                        VStack(spacing: 20){
                            HStack{
                                Text("В ожидании: \(allOrder.countWaitPerson)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.pink)
                                    .shadow(radius: 0.5)
                                Spacer()
                            }
                        HStack{
                            Text("В работе: \(allOrder.countInWork)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.yellow)
                                .shadow(radius: 0.5)
                            Spacer()
                        }
                            HStack{
                                Text("Завершенные: \(allOrder.countCompleted)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.green)
                                    .shadow(radius: 0.5)
                                Spacer()
                            }
                            
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 2)
                    }
                    else{
                        
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Статистика")
            .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
            .toolbar{
                Button{
                    self.showSheet.toggle()
                }label: {
                    Image(systemName: "calendar")
                        .resizable()
                        .foregroundColor(Color.purple)
                        .frame(width: 30, height: 30)
                }
//                Button{
//                    print("reload")
//                }label: {
//                    Image(systemName: "calendar")
////                    Text("перезагрузка")
//                }
            }
        }
        .sheet(isPresented: $showSheet){
            if isOfDay{
                ShowStaticOfDay()
            }else{
                ShowStaticPersonOfDay()
            }
        }
    }
}

struct StatisticsAdmin_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsAdmin()
    }
}
