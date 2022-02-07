//
//  ContentView.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct ContentView: View {
    
    private func handleAction(){
        if isLoginMode{
            Login().loginUser(email: emailText, password: passwordText)
        }else{
            Registration().regUser(email: emailText, password: passwordText, image: imageProfile!, name: nameProfile, surname: surnameProfile, numberPhone: numberPhone)
        }
    }
    
    @State var isLoginMode = false
    @State var emailText = ""
    @State var passwordText = ""
    @State var nameProfile = ""
    @State var surnameProfile = ""
    @State var numberPhone = ""
    @State var showImagePicker = false
    @State var imageProfile: UIImage?
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 10){
                    
                    if !isLoginMode{
                        Button{
                            showImagePicker.toggle()
                        }label: {
                            VStack{
                                if let image = self.imageProfile{
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                }
                                else{
                                    Image("Logo-MPT")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                        .stroke(Color.black, lineWidth: 3))
                            .shadow(color: .black, radius: 2, x: 2, y: 2)
                        }
                        .padding()
                    }
                    
                    Group{
                        HStack {
                            TextField("Email", text: $emailText)
                                .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            Divider()
                            Text("@mpt.ru")
                        }
                        if !isLoginMode{
                            TextField("Имя", text: $nameProfile)
                            TextField("Фамилия", text: $surnameProfile)
                            TextField("Номер телефона", text: $numberPhone)
                                .keyboardType(.phonePad)
                        }
                    SecureField("Пароль", text: $passwordText)
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    
                    Button{
                        self.handleAction()
                    }label: {
                        HStack{
                            Spacer()
                            Text(isLoginMode ? "Войти" : "Регистрация")
                            Spacer()
                        }
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .background(Color.blue)
                        .cornerRadius(32)
                        .padding()
                        .shadow(radius: 15)
                    }
                    
                    
                    Button(isLoginMode ? "У меня еще нет аккаунта" : "У меня уже есть аккаунт"){
                        isLoginMode.toggle()
                    }
                }
                .padding()
                
            }
            .navigationTitle(isLoginMode ? "Авторизация" : "Регистрация")
            .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
            .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil){
                ImagePicker(image: $imageProfile)
                    .ignoresSafeArea()
        }
       
        
        }
    }
    
    
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
