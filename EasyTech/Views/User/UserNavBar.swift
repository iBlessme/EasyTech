//
//  UserNavBar.swift
//  EasyTech
//
//  Created by iBlessme on 08.02.2022.
//

import SwiftUI
import FirebaseFirestore
import SDWebImageSwiftUI
import FirebaseAuth

struct UserNavBar: View {
    
    @State var shouldShowLogOutOptions = false
    @State var showPersonView = false
    @State var showSettingProfile = false
    @State var isLogOut = false
    
    @ObservedObject private var vm = UserModel()
    
    var body: some View {
        HStack(spacing: 16){
            WebImage(url: URL(string: vm.userModel?.imageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth: 1))
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 0.1){
                Text("\(vm.userModel?.name ?? "") \(vm.userModel?.surname ?? "")")
                    .font(.system(size: 24, weight: .bold))
                
                Text("\(vm.userModel?.email ?? "")")
                    .font(.system(size: 14, weight: .bold))
               
            }
            Spacer()
            Button{
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
            
        }
        .padding()
        .actionSheet(isPresented: $shouldShowLogOutOptions){
            .init(title: Text("Настройки"), message: Text("Что вы хотите сделать?"), buttons: [
                .default(
                Text("Войти как сотрудник"),
                action: {
                    self.showPersonView.toggle()
                }
                ),
                .default(
                Text("Изменить профиль"),
                action: {
                    self.showSettingProfile.toggle()
                }
                ),
                .destructive(Text("Выйти"), action: {
                    print("Out")
                    do{
                        try Auth.auth().signOut()
                        self.isLogOut = true
                    }
                    catch{
                        print("Ошибка при выходе")
                        
                    }
                    
                }),
                
                    .cancel()
            ])
        }
        .fullScreenCover(isPresented: $showPersonView){
            MainPersonView()
        }
        .fullScreenCover(isPresented: $isLogOut){
            ContentView()
        }
        .sheet(isPresented: $showSettingProfile){
            SettingUserView()
        }
    }
}

struct UserNavBar_Previews: PreviewProvider {
    static var previews: some View {
        UserNavBar()
    }
}
