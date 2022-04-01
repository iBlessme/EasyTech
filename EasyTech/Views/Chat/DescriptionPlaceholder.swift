//
//  DescriptionPlaceholder.swift
//  EasyTech
//
//  Created by iBlessme on 23.02.2022.
//

import SwiftUI

struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Сообщение")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}

struct DescriptionPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionPlaceholder()
    }
}
