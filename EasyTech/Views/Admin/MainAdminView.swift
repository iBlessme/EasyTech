//
//  MainAdminView.swift
//  EasyTech
//
//  Created by iBlessme on 02.03.2022.
//

import SwiftUI

struct MainAdminView: View {
    var body: some View {
        VStack{
            PersonNavBarView()
            TabView{
                AllOrdersAdmin()
                    .tabItem{
                        Text("Заявки")
                        Image(systemName: "folder.fill")
                    }
                StatisticsAdmin()
                    .tabItem{
                        Text("Статистика")
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                ChatPersonView()
                    .tabItem{
                        Text("Сообщения")
                        Image(systemName: "message.fill")
                    }
            }
            .accentColor(Color.purple)
        }
        .padding(.horizontal)
        .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
    }
}

struct MainAdminView_Previews: PreviewProvider {
    static var previews: some View {
        MainAdminView()
    }
}
