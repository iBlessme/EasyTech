//
//  MainPersonView.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import SwiftUI
import FirebaseAuth

struct MainPersonView: View {
    var body: some View {
        
            VStack{
                PersonNavBarView()
                TabView{
                    ListOrdersPersonView()
                        .tabItem{
                            Text("Входящие")
                            Image(systemName: "folder.fill.badge.plus")
                               
                        }
                      
                    ListActivOrdersView()
                        .tabItem{
                            Text("Активные")
                            Image(systemName: "folder.fill")
                               
                        }
                        
                    ChatPersonView()
                        .tabItem{
                            Text("Сообщения")
                            Image(systemName: "message.fill")
                               
                        }
                       
                }
                .accentColor(Color.purple)
            }
            
//            .navigationBarHidden(true)
            .padding(.horizontal)
            .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
            
        
    }
}

struct MainPersonView_Previews: PreviewProvider {
    static var previews: some View {
        MainPersonView()
    }
}
