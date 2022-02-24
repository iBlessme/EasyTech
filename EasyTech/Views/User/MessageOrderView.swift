//
//  MessageOrderView.swift
//  EasyTech
//
//  Created by iBlessme on 08.02.2022.
//

import SwiftUI

struct MessageOrderView: View {
    
    @State var showAddOrder = false
//    @Binding var isPresented: Bool
    
    var body: some View {
        Button{
            self.showAddOrder.toggle()
        }label: {
            HStack {
                Spacer()
                Text("+ Создать заявку")
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
        .sheet(isPresented: $showAddOrder){
            AddOrderView(isVisible: self.$showAddOrder)
        }
    }
}

struct MessageOrderView_Previews: PreviewProvider {
    static var previews: some View {
        MessageOrderView()
    }
}
