//
//  ContentView.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct ContentView: View {
    
    private func handleAction(){
        if isLoginMode{
            if checkValidationAuth(){
                self.loginUser()
            }
           
        }else{
            if checkValidationReg(){
                self.regUser()
            }
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
    @State var showActonSheet = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showMainMenu = false
    @State var showAlertError = false
    @State var showAlertRegistValidation = false
    @State var showAlertAboutPhone = false
    @State var showAlertLoginValid = false
    @State var showAlertLoginError = false
    @State var showAlertAboutPassword = false
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 10){
                    if !isLoginMode{
                        Button{
                            self.showActonSheet.toggle()
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
                        .background(Color.purple)
                        .cornerRadius(32)
                        .padding()
                        .shadow(radius: 15)
                    }
                    
                    
                    Button(isLoginMode ? "У меня еще нет аккаунта" : "У меня уже есть аккаунт"){
                        isLoginMode.toggle()
                    }
                    .foregroundColor(Color.purple)
                }
                .padding()
                
            }
            .navigationTitle(isLoginMode ? "Авторизация" : "Регистрация")
            .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
            .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil){
                ImagePicker(image: $imageProfile, isShown: $showImagePicker, sourceType: self.sourceType)
                    .ignoresSafeArea()
                
            }
            .fullScreenCover(isPresented: $showMainMenu){
                MainUserView()
            }
                .actionSheet(isPresented: $showActonSheet){
                        .init(title: Text("Настройки"), message: Text("Что вы хотите сделать?"), buttons: [
                            .default(
                            Text("Выбрать из галереи"),
                            action: {
                                self.showImagePicker.toggle()
                                self.sourceType = .photoLibrary
                            }
                            ),
                            .default(
                            Text("Открыть камеру"),
                            action: {
                                self.showImagePicker.toggle()
                                self.sourceType = .camera
                            }
                            ),
                                .cancel()
                        ])
                            }
                        }
        .alert("Неверно введены данные", isPresented: $showAlertError){
            Button("ОК", role: .cancel) {}
        }
        .alert("Некорректный номер телефона", isPresented: $showAlertAboutPhone){
            Button("ОК", role: .cancel) {}
        }
        .alert("Не все поля заполнены", isPresented: $showAlertLoginValid){
            Button("ОК", role: .cancel) {}
        }
        .alert("Неверно введены данные", isPresented: $showAlertLoginError){
            Button("ОК", role: .cancel) {}
        }
        .alert("Остались пустые поля", isPresented: $showAlertRegistValidation){
            Button("ОК", role: .cancel) {}
        }
        .alert("Пароль слишком короткий", isPresented: $showAlertAboutPassword){
            Button("ОК", role: .cancel) {}
        }
        
    }
        
    
    
    func loginUser(){
        Auth.auth().signIn(withEmail: "\(emailText)@mpt.ru", password: passwordText){response, error in
            if error != nil{
                print("ОшибОчка")
                self.showAlertLoginError.toggle()
                return
            }
            print("Succes Auth")
            self.showMainMenu.toggle()
        }
        
    }
    
    
    func regUser(){
        Auth.auth().createUser(withEmail: "\(emailText)@mpt.ru", password: passwordText){
            result, error in
            if error != nil{
                print("failed")
                self.showAlertError.toggle()
                return
            }
            self.imageToStorage(imageP: (imageProfile ?? UIImage(named: "Logo-MPT"))!)
        }
    }
    
    private func imageToStorage(imageP: UIImage){
        let user = Auth.auth().currentUser
        let uid = user!.uid
        let ref = Storage.storage().reference().child("users").child(uid)
        
        guard let imageData = imageP.jpegData(compressionQuality: 0.4) else {return}
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = ref.putData(imageData, metadata: metadata) {metadata, error in
            if let error = error{
                print("Failed image 1 \(error)")
            }
            guard let metadata = metadata else {return}
            _ = metadata.size
            ref.downloadURL{ url, error in
                guard let downloadUrl = url else {return}
                self.storeUserInformation(imageProfileUrl: downloadUrl)
                print("Success upload image")
            }
        }
    }
    private func storeUserInformation(imageProfileUrl: URL){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userData = [
            "email": "\(emailText)@mpt.ru",
            "uid" : uid,
            "profileImageUrl": imageProfileUrl.absoluteString,
            "name" : nameProfile,
            "surname" : surnameProfile,
            "password" : passwordText,
            "numberPhone" : numberPhone,
            "permission" : "4"
        ] as [String : Any]
        Firestore.firestore().collection("users")
            .document(uid).setData(userData){ err in
                if let err = err{
                    print(err)
                    return
                }
                print("Success")
                self.showMainMenu.toggle()
            }
    }
    func checkValidationReg() -> Bool{
        if emailText.isEmpty, passwordText.isEmpty, surnameProfile.isEmpty, numberPhone.isEmpty, nameProfile.isEmpty{
            self.showAlertRegistValidation.toggle()
            return false
        }
        else if numberPhone.count != 11{
                self.showAlertAboutPhone.toggle()
            return false
        }
        else if passwordText.count < 6{
            self.showAlertAboutPassword.toggle()
                return false
            }
        return true
    }
    
    func checkValidationAuth()-> Bool{
        if emailText.isEmpty, passwordText.isEmpty{
            self.showAlertLoginValid.toggle()
            return false
        }
        return true
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
