//
//  ChatView.swift
//  EasyTech
//
//  Created by iBlessme on 23.02.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct ChatView: View {
     
    @State var chatText = ""
    @Binding var uid: String
    @ObservedObject var ms = MessageViewModel()
    
    var body: some View {
        ZStack{
            messageView
            VStack(spacing: 0){
                Spacer()
                chatBottomBar
                    .background(Color.white.ignoresSafeArea())
            }
        }
    }
    static let emptyScrollToString = "Empty"
    
    private var messageView: some View{
        ScrollView {
            ScrollViewReader{ scrollViewProxy in
            ForEach(ms.message, id: \.self) { messages in
                if messages.fromID == uid || messages.toId == uid{
                    if messages.toId != Auth.auth().currentUser?.uid{
                        HStack {
                            Spacer()
                           
                            HStack {
                               Text(messages.text)
                                   .foregroundColor(.white)
                                    }
                                   .padding()
                                   .background(Color.purple)
                                   .cornerRadius(20)
                                   .shadow(color: .black, radius: 2, x: 1, y: 1)
                                }
                                   .padding(.horizontal)
                                   .padding(.top, 8)
                        }else{
                            HStack {
                        
                                HStack {
                                    Text(messages.text)
                                        .foregroundColor(.black)
                                        }
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(20)
                                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                                Spacer()
                                    }
                                    .padding(.horizontal)
                                    .padding(.top, 8)
                            }
                        }
                    }
                           HStack{ Spacer() }
                           .frame(height: 50)
                           .id(Self.emptyScrollToString)
                           .onReceive(ms.$count) { _ in
                               withAnimation(.easeOut(duration: 0.5)) {
                                   scrollViewProxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                               }
                               
                           }
                    }
                }
                .padding()
                .background(Color(.init(white: 0.95, alpha: 1)))
              
    }
    
    private var chatBottomBar: some View {
            HStack(spacing: 16) {
                ZStack {
                   
                    DescriptionPlaceholder()
                    TextEditor(text: $chatText)
                        .opacity(chatText.isEmpty ? 0.5 : 1)
                                    }
                .frame(height: 40)

                Button {

                    MessageViewModel().handleSend(toID: uid, text: chatText)
                    self.chatText = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 10)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.purple)
                .cornerRadius(20)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(uid: .constant(""))
    }
}
