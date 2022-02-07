//
//  MainUserView.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import SwiftUI
import FirebaseAuth

struct MainUserView: View {
    var body: some View {
        VStack {
            Text("User")
            Button{
                do{
                            try Auth.auth().signOut()
                        }catch{
                            print("Ошибка при выходе")
                        }
            }label: {
                Text("Выйти нахуй")
            }
        }
    }
}

struct MainUserView_Previews: PreviewProvider {
    static var previews: some View {
        MainUserView()
    }
}
