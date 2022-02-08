//
//  OrdersUserView.swift
//  EasyTech
//
//  Created by iBlessme on 08.02.2022.
//

import SwiftUI

struct OrdersUserView: View {
    var body: some View {
        ScrollView{
            ForEach(1..<2, id: \.self){ num in
                VStack{
                    Image("Logo-MPT")
                    Divider()
                    Text("sd")
                }
                
            }
        }
    }
}

struct OrdersUserView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersUserView()
    }
}
