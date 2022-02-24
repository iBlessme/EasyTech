//
//  ListActivOrdersView.swift
//  EasyTech
//
//  Created by iBlessme on 10.02.2022.
//

import SwiftUI

struct ListActivOrdersView: View {
    
    @ObservedObject private var vm = GetActiveOrders()
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
    @State var numberPhone = ""
    
    var body: some View {
        NavigationView{
            List{
                ForEach(vm.activeOrders){ order in
                    NavigationLink(destination: AboutOrderView(id: $id, imageOrder: $imageOrder, housing: $housing, floor: $floor, description: $description, hall: $hall, status: $status, dateRegistration: $dateRegistration, dateCompleted: $dateCompleted, idClient: $idClient, idPerson: $idPerson, userosition: $userPosition, phoneNumber: $numberPhone)
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
                        self.numberPhone = order.numberPhone

                    }){
                        VStack{
                        HStack{
                            
                            Text("Корпус: \(order.housing)")
                            Spacer()
                            Text("Кабинет: \(order.hall)")
                        
                            
                        }
                        .font(Font.system(size: 15, weight: .bold))
                        .shadow(radius: 10)
                            HStack{
                                Text("Статус: \(order.status)")
                                    .font(Font.system(size: 20, weight: .bold))
                                Spacer()
                            }
                            .padding(.vertical, 3)
                        }
                        
                        
                    }
                    
                    .padding()
                    
                    
                        
                    
                }
                
                }
            .refreshable {
                do{
                    
                   await vm.reload()
                }
            }
            
            .listStyle(.plain)
            .refreshable {
                print("Success")
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Активные заказы")
            .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
        }
    }
}

struct ListActivOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        ListActivOrdersView()
    }
}
