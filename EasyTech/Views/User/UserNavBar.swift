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
    @State var showAdminView = false
    @State var showSettingProfile = false
    @State var isLogOut = false
    @State var updateView = false
    @State var alertErrorGoPosition = false
    
    @State var name = ""
    @State var surname = ""
    @State var phoneNumber = ""
    @State var image = ""
    
    @ObservedObject private var vm = UserModel()
    @ObservedObject private var or = GetOrderToUSer()
    
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
                    .font(.system(size: 20, weight: .bold))
                
                Text("\(vm.userModel?.email ?? "")")
                    .font(.system(size: 14, weight: .bold))
               
            }
            Spacer()
            Button{
         
                GetOrderToUSer().reload()

                self.updateView.toggle()
                print("Succes")
            }label: {
                Image(systemName: "arrow.counterclockwise")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }

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
            .init(title: Text("Настройки"), message: Text("Выберите действие"), buttons: [
                .default(
                Text("Войти как сотрудник"),
                action: {
                    self.checkPosition()
                }
                ),
                .default(
                Text("Изменить профиль"),
                action: {
                    self.updateInfoView()
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
            SettingUserView(isVisible: $showSettingProfile,name: self.$name, surname: self.$surname, numberPhone: self.$phoneNumber, image: self.$image)
        }
        .fullScreenCover(isPresented: $updateView){
            MainUserView()
        }
        .fullScreenCover(isPresented: $showAdminView){
            MainPersonView()
        }
        .alert("Ошибка входа. У вас недостаточно прав",isPresented: $alertErrorGoPosition){
            Button("ОК"){
                self.alertErrorGoPosition = false
            }
        }
    }
    
    func updateInfoView(){
        self.name = vm.userModel?.name ?? ""
        self.surname = vm.userModel?.surname ?? ""
        self.phoneNumber = vm.userModel?.numberPhone ?? ""
        self.image = vm.userModel?.imageUrl ?? ""
    }
    
    func checkPosition() {
        let position = vm.userModel?.permission
        if position == "4"{
            self.alertErrorGoPosition = true
            
        }
        else if position == "3" || position == "2"{
            self.showPersonView.toggle()
            
        }
        else if position == "1"{
            self.showAdminView.toggle()
            
        }
        else{
            return
            
        }
    }
}

struct UserNavBar_Previews: PreviewProvider {
    static var previews: some View {
        UserNavBar()
    }
}
