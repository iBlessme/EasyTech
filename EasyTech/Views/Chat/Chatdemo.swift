//
//  Chatdemo.swift
//  EasyTech
//
//  Created by iBlessme on 23.02.2022.
//

import SwiftUI

struct Chatdemo: View {
    var body: some View {
        List(1..<20, id: \.self){ nim in
            
            HStack{
                Spacer()
                HStack{
                    Text("text")
                        .foregroundColor(Color.white)
                }
                .padding()
                .background(Color.purple)
                .cornerRadius(20)
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .listStyle(.sidebar)
       
    }
        
}

struct Chatdemo_Previews: PreviewProvider {
    static var previews: some View {
        Chatdemo()
    }
}
