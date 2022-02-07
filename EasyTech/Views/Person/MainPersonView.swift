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
        VStack {
            Text("Person")
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

struct MainPersonView_Previews: PreviewProvider {
    static var previews: some View {
        MainPersonView()
    }
}
