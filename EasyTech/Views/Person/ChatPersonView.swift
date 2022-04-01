//
//  ChatPersonView.swift
//  EasyTech
//
//  Created by iBlessme on 10.02.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatPersonView: View {
    
    @ObservedObject var usersChat = UserModel()
    @ObservedObject var ms = MessageViewModel()
    @State var isShowMessages = false
    @State var userUid = ""

    
    
    var body: some View {
        ScrollView{
            ForEach(usersChat.chatUser, id: \.self){ user in
                Button{
                    self.isShowMessages.toggle()
                    self.userUid = user.id
                    print(userUid)
                }label: {
                    VStack{
                        HStack{
                            WebImage(url: URL(string: user.imageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .cornerRadius(50)
                                    .overlay(RoundedRectangle(cornerRadius: 44)
                                            .stroke(Color(.label), lineWidth: 1))
                                    .shadow(radius: 1)
    
                                    VStack(alignment: .leading){
                                        Text("\(user.name) \(user.surname)")
                                            .font(.system(size: 16, weight: .bold))
                                        Text("\(user.email)")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(.lightGray))
                                    
                                        }
                                       
                                    Spacer()
                                      }
                                      Divider()
                                          .padding(.vertical, 8)
                                  }
                                  .padding(.horizontal)
                }
                
              
            }
            .padding(.bottom, 50)
        }
        .background(Color(.init(white: 0, alpha: 0.07)).ignoresSafeArea(.all))
        .sheet(isPresented: $isShowMessages, onDismiss: nil){
            ChatView(uid: self.$userUid)
        }
}

struct ChatPersonView_Previews: PreviewProvider {
    static var previews: some View {
        ChatPersonView()
        }
    }
}
