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
    
    private var messageView: some View{
        
        ScrollView {
            ForEach(ms.message, id: \.self) { messages in
                       HStack {
                           Spacer()
                           HStack {
                               Text(messages.text)
                                   .foregroundColor(.white)
                           }
                           .padding()
                           .background(Color.purple)
                           .cornerRadius(20)
                       }
                       .padding(.horizontal)
                       .padding(.top, 8)
                   }

                   HStack{ Spacer() }
                   .frame(height: 50)
               }
               .background(Color(.init(white: 0.95, alpha: 1)))
    }
    
    private var chatBottomBar: some View {
            HStack(spacing: 16) {
                Image(systemName: "photo.on.rectangle")
                    .font(.system(size: 24))
                    .foregroundColor(Color(.darkGray))
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
