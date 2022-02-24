//
//  SettingUserView.swift
//  EasyTech
//
//  Created by iBlessme on 08.02.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct SettingUserView: View {
    
    @Binding var isVisible: Bool
    @ObservedObject var vm = UserModel()
    @Binding var name: String
    @Binding var surname: String
    @Binding var numberPhone: String
    @Binding var image: String
    @State var showActonSheet = false
    @State var imageProfile: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showImagePicker = false
    @State var checkDownloadImage = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Button{
                        self.showActonSheet.toggle()
                    }label: {
                        VStack{
                            if let image = self.imageProfile{
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .clipped()
                                    .cornerRadius(100)
                                    .overlay(RoundedRectangle(cornerRadius: 100)
                                                .stroke(Color(.label), lineWidth: 0.1))
                                    .shadow(radius: 5)
                            }
                            else{
                        WebImage(url: URL(string: image ))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipped()
                            .cornerRadius(100)
                            .overlay(RoundedRectangle(cornerRadius: 100)
                                        .stroke(Color(.label), lineWidth: 0.1))
                            .shadow(radius: 5)
                            }
                        }
                    }
                    Group{
                        TextField("Имя", text: $name)
                        TextField("Фамилия", text: $surname)
                        TextField("Номер телефона", text: $numberPhone)
                        
                    }
                    .autocapitalization(.none)
                    .padding(12)
                    .background(Color.white)
                .cornerRadius(20)
                .font(Font.system(size: 15, weight: .bold))
                   
                    Button{
                        UserModel().checkPickPhoto(name: name, surname: surname, phoneNumber: numberPhone, imageURL: (imageProfile ?? UIImage(systemName: "person.fill"))!, isPicker: checkDownloadImage)
                        self.isVisible.toggle()
                    }label: {
                        HStack {
                            Spacer()
                            Text("Сохранить")
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
                    .padding(.top, 50)
                }
                .padding()
                
                
                
            }
            
            
            .navigationTitle("Настройки")
            .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
            .actionSheet(isPresented: $showActonSheet){
                    .init(title: Text("Настройки"), message: Text("Что вы хотите сделать?"), buttons: [
                        .default(
                        Text("Выбрать из галереи"),
                        action: {
                            self.showImagePicker.toggle()
                            self.sourceType = .photoLibrary
                            self.checkDownloadImage.toggle()
                        }
                        ),
                        .default(
                        Text("Открыть камеру"),
                        action: {
                            self.showImagePicker.toggle()
                            self.sourceType = .camera
                            self.checkDownloadImage.toggle()
                        }
                        ),
                        .cancel(Text("Закрыть"), action: {
                            self.checkDownloadImage.toggle()
                        })
                    ])
                        }
            .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil){
                ImagePicker(image: $imageProfile, isShown: $showImagePicker, sourceType: self.sourceType)
                    .ignoresSafeArea()
                
            }
        }
        
    }
}

struct SettingUserView_Previews: PreviewProvider {
    static var previews: some View {
        SettingUserView(isVisible: .constant(true),name: .constant(""), surname: .constant(""), numberPhone: .constant(""), image: .constant(""))
    }
}
