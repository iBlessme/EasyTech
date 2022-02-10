//
//  ListOrdersPersonView.swift
//  EasyTech
//
//  Created by iBlessme on 10.02.2022.
//

import SwiftUI

struct ListOrdersPersonView: View {
    
    @ObservedObject private var vm = GetAllOrders()
    @ObservedObject private var user = UserModel()
    
    @State var id = ""
    @State var imageOrder = ""
    @State var housing = ""
    @State var floor = ""
    @State var description = ""
    @State var hall = ""
    @State var status = ""
    @State var dateRegistration = ""
    @State var dateCompleted = ""
    @State var idClient = ""
    @State var idPerson = ""
    @State var userPosition = ""
    
    var body: some View {
        NavigationView{
        List{
            ForEach(vm.allOrders){ order in
                NavigationLink(destination: AboutOrderView(id: $id, imageOrder: $imageOrder, housing: $housing, floor: $floor, description: $description, hall: $hall, status: $status, dateRegistration: $dateRegistration, dateCompleted: $dateCompleted, idClient: $idClient, idPerson: $idPerson, userosition: $userPosition)
                                .onAppear{
                    self.id = order.id
                    self.imageOrder = order.imageOrder
                    self.housing = order.housing
                    self.floor = order.floor
                    self.description = order.description
                    self.hall = order.hall
                    self.status = order.status
                    self.dateRegistration = order.dateRegistration
                    self.dateCompleted = order.dateCompleted
                    self.idClient = order.idClient
                    self.idPerson = order.idPerson
                    self.userPosition = user.userModel?.permission ?? ""

                }){
                    HStack{
                        
                        Text("Корпус: \(order.housing)")
                        Spacer()
                        Text("Кабинет: \(order.hall)")
                    
                        
                    }
                    .font(Font.system(size: 15, weight: .bold))
                    .shadow(radius: 10)
                   
                    
                    
                    
                }
                
                .padding()
                
                
                    
                
            }
            
            }
        
        .listStyle(.plain)
        .refreshable {
            print("Success")
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Все заказы")
        .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
        }
        
    }
}

struct ListOrdersPersonView_Previews: PreviewProvider {
    static var previews: some View {
        ListOrdersPersonView()
    }
}
