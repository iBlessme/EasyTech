//
//  AllOrdersAdmin.swift
//  EasyTech
//
//  Created by iBlessme on 02.03.2022.
//

import SwiftUI




struct AllOrdersAdmin: View {
    
    @State var isOrder = 1
    
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
    @State var numberPhone = ""
    @State var userName = ""
    @State var namePerson = ""
    @State var surnamePerson = ""
    
    var body: some View {
        NavigationView{
        VStack{
            Picker(selection: $isOrder, label: Text("Статус")){
                Text("В ожидании")
                    .tag(1)
                Text("В работе")
                    .tag(2)
                Text("Завершенные")
                    .tag(3)

            }
            .pickerStyle(.segmented)
            List{
                ForEach(vm.allOrders){ order in
                    if order.status == "В ожидании сотрудника" && isOrder == 1{
                        NavigationLink(destination: AboutOrderAdmin(id: $id, imageOrder: $imageOrder, housing: $housing, floor: $floor, description: $description, hall: $hall, status: $status, dateRegistration: $dateRegistration, dateCompleted: $dateCompleted, idClient: $idClient, idPerson: $idPerson, userosition: $userPosition, phoneNumber: $numberPhone, namePerson: $namePerson, surnamePerson: $surnamePerson).onAppear{
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
                            self.namePerson = order.namePerson
                            self.surnamePerson = order.surnamePerson
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
                                    Text("Описание: \(order.description)")
                                        .font(Font.system(size: 20))
                                    Spacer()
                                }
                                .padding(.vertical, 3)
                                HStack{
                                Text("Дата: \(order.dateRegistration)")
                                    Spacer()
                                }
                                .padding(.vertical, 3)
                            }
                        }
                    }else if order.status == "В работе" && isOrder == 2{
                        NavigationLink(destination: AboutOrderAdmin(id: $id, imageOrder: $imageOrder, housing: $housing, floor: $floor, description: $description, hall: $hall, status: $status, dateRegistration: $dateRegistration, dateCompleted: $dateCompleted, idClient: $idClient, idPerson: $idPerson, userosition: $userPosition, phoneNumber: $numberPhone, namePerson: $namePerson, surnamePerson: $surnamePerson).onAppear{
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
                            self.namePerson = order.namePerson
                            self.surnamePerson = order.surnamePerson
                            
                        }){
                            VStack{
                               
                                    Text("Сотрудник: \(order.namePerson) \(order.surnamePerson)")
                                        .font(Font.system(size: 20, weight: .bold))
                                        .foregroundColor(Color.purple)
                                .padding(.vertical, 3)
                                HStack{
                                    Text("Корпус: \(order.housing)")
                                    Spacer()
                                    Text("Кабинет: \(order.hall)")
                                }
                                .font(Font.system(size: 15, weight: .bold))
                                .shadow(radius: 10)
                                
                                HStack{
                                    Text("Описание: \(order.description)")
                                        .font(Font.system(size: 20))
                                    Spacer()
                                }
                                .padding(.vertical, 3)
                                HStack{
                                Text("Дата: \(order.dateRegistration)")
                                    Spacer()
                                }
                                .padding(.vertical, 3)
                                
                               
                            }
                        }
                    }else if order.status == "Завершен" && isOrder == 3{
                        NavigationLink(destination: AboutOrderAdmin(id: $id, imageOrder: $imageOrder, housing: $housing, floor: $floor, description: $description, hall: $hall, status: $status, dateRegistration: $dateRegistration, dateCompleted: $dateCompleted, idClient: $idClient, idPerson: $idPerson, userosition: $userPosition, phoneNumber: $numberPhone, namePerson: $namePerson, surnamePerson: $surnamePerson).onAppear{
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
                            self.namePerson = order.namePerson
                            self.surnamePerson = order.surnamePerson
                            
                        }){
                            VStack{
                                
                                    Text("Сотрудник: \(order.namePerson) \(order.surnamePerson)")
                                        .font(Font.system(size: 20, weight: .bold))
                                        .foregroundColor(Color.purple)
                                
                                .padding(.vertical, 3)
                                HStack{
                                    Text("Корпус: \(order.housing)")
                                    Spacer()
                                    Text("Кабинет: \(order.hall)")
                                }
                                .font(Font.system(size: 15, weight: .bold))
                                .shadow(radius: 10)
                                
                                HStack{
                                    Text("Описание: \(order.description)")
                                        .font(Font.system(size: 20))
                                    Spacer()
                                }
                                .padding(.vertical, 3)
                                HStack{
                                Text("Дата: \(order.dateRegistration)")
                                    Spacer()
                                }
                                .padding(.vertical, 3)
                                HStack{
                                Text("Завершен: \(order.dateCompleted)")
                                    Spacer()
                                }
                                .padding(.vertical, 3)
                               
                            }
                        }
                    }
                    else{
                        
                    }
                }
            }
            .refreshable{
                do{
                    await vm.reload()
                }
            }
            .listStyle(.plain)
            }
        .navigationBarTitle("Все заказы")
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
            
        }
    }
    
}

struct AllOrdersAdmin_Previews: PreviewProvider {
    static var previews: some View {
        AllOrdersAdmin()
    }
}
