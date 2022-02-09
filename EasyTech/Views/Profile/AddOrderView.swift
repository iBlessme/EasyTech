//
//  AddOrderView.swift
//  EasyTech
//
//  Created by iBlessme on 08.02.2022.
//

import SwiftUI

struct AddOrderView: View {
    
    @Binding var isVisible: Bool
    @State var showAddOrder = false
    @State var image: UIImage?
    @State var showImagePicker = false
    @State var housing = "Нахимовский"
    @State var floor = 1
    @State var hall = ""
    @State var description = ""
    @State var showActonSheet = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showAlertError = false
    @State var checkAlertValdi = false
    @State var showErrorAboutDesc = false
    
    var body: some View {
        NavigationView{
            ScrollView{
        VStack{
            Button{
                self.showActonSheet.toggle()
            }label: {
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 150)
                        .cornerRadius(20)
                }
                else{
                    Image(systemName: "camera.fill")
                        .font(.system(size: 140))
                        .padding()
                        .foregroundColor(Color.black)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 10))
                }
            }
            .font(.system(size: 64))
            .padding()
            .foregroundColor(Color(.label))
            
            Divider()
            Picker(selection: $housing, label: Text("Корпус")){
                Text("Нахимовский")
                    .tag("Нахимовский")
                Text("Нежинская")
                    .tag("Нежинская")
            }
            .pickerStyle(.segmented)
            Text("Выберите этаж")
                .padding(.top)
            if housing == "Нахимовский"{
                Picker(selection: $floor, label: Text("Этаж")){
                    Text("1")
                        .tag(1)
                    Text("2")
                        .tag(2)
                    Text("3")
                        .tag(3)
                }
                .pickerStyle(.segmented)
            }
            else{
                Picker(selection: $floor, label: Text("Этаж")){
                    Text("-1")
                        .tag(-1)
                    Text("1")
                        .tag(1)
                    Text("2")
                        .tag(2)
                    Text("3")
                        .tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            VStack {
                TextField("Кабинет", text: $hall)
                    .keyboardType(.numberPad)
                    .autocapitalization(.none)
                    .padding(12)
                    .background(Color.white)
                .cornerRadius(20)
                    
                TextField("Краткое описание", text: $description)
                    .autocapitalization(.none)
                    .padding(12)
                    .background(Color.white)
                .cornerRadius(20)
                    
            }
            .padding()
            
            Button{
                if checkValid(){
                AddOrder().imageToStorage(imageOrder: image!, housing: housing, floor: floor, description: description, hall: hall)
                    self.isVisible = false
                }
            }label: {
                HStack {
                    Spacer()
                    Text("Отправить")
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
            
            
        }
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil){
            ImagePicker(image: $image, isShown: $showImagePicker, sourceType: self.sourceType)
                .ignoresSafeArea()
        }
        .alert("Остались пустые поля", isPresented: $showAlertError){
            Button("ОК", role: .cancel) {}
        }
        .actionSheet(isPresented: $showActonSheet){
            .init(title: Text("Настройки"), message: Text("Что вы хотите сделать?"), buttons: [
                .default(
                Text("Выбрать из галереи")
                    .foregroundColor(Color.purple),
                action: {
                    self.showImagePicker.toggle()
                    self.sourceType = .photoLibrary
                }
                ),
                .default(
                Text("Открыть камеру")
                    .foregroundColor(Color.purple),
                action: {
                    self.showImagePicker.toggle()
                    self.sourceType = .camera
                }
                )
                    ,
                .cancel()
            ])
                }
        
        .padding()
        }
        .navigationTitle("Создание заявки")
        .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea())
        }
        
        
    }
    func checkValid() -> Bool{
        if hall.isEmpty, description.isEmpty{
            self.showAlertError.toggle()
            return false
        }
        else if description.count > 150{
            self.showErrorAboutDesc.toggle()
            return false
        }
        return true
    }
}

struct AddOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrderView(isVisible: .constant(true))
    }
}
