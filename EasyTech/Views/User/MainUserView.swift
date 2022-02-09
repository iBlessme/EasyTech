//
//  MainUserView.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import SwiftUI
import FirebaseAuth

struct MainUserView: View {
    
    @State var shouldShowLogOutOptions = false
    @ObservedObject private var vm = UserModel()
    
    var body: some View {
        VStack {
            UserNavBar()
//            Divider()
            OrdersUserView()
            
        }
        
        .overlay(
            MessageOrderView()
        , alignment: .bottom)
        .navigationBarHidden(true)
        .padding()
        .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
    }
    
}

struct MainUserView_Previews: PreviewProvider {
    static var previews: some View {
        MainUserView()
    }
}
