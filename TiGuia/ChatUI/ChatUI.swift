//
//  ChatUI.swift
//  TiGuia
//
//  Created by Palloma Ramos on 23/11/20.
//

import SwiftUI
import PhotosUI
import Firebase

struct MessageData: Identifiable {
    enum DataType {
        case image(imageIndex: Int)
        case text(message: String)
    }
    let isMine: Bool
    let dataType: DataType
    let id = UUID()
}

struct ChatUI : View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let chatroom: Chatroom
    @ObservedObject var viewModel = MessagesViewModel()
    static var pickerResult: [UIImage] = []
    @State private var fullText: String = ""
    @State private var messageData: [MessageData] = []
    @StateObject private var keyboard = KeyboardResponder()
    var scrollToid = 99
    @State private var isPickerPresented: Bool = false
    var config: PHPickerConfiguration  {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images //videos, livePhotos...
        config.selectionLimit = 0 //0 => any, set 1-2-3 for hard limit
        return config
        
    }
    func Scroll(reader :ScrollViewProxy) -> some View {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation {
                reader.scrollTo(scrollToid)
            }
        }
        return EmptyView()
    }
    init(chatroom: Chatroom){
        self.chatroom = chatroom
        viewModel.fetchData(docId: chatroom.id)
    }
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                //
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.btnColor)
                    .frame(width: 20, height: 20)
                    .font(.system(size: 25))
                    .padding(.trailing, 370.0)
                    .padding(.top)
            }
            
            HStack {
                VStack(alignment: .leading)  {
                    
                    Text("Mentoria com \(chatroom.mentorName!)")
                        .font(.custom("Raleway-Bold", size: 30))
                        .foregroundColor(.titleColor)
                    
                    Text("Professora de Computação")
                        .font(.custom("Raleway-Regular", size: 18))
                        .foregroundColor(.darkColor)
                }
                .padding(.top)
                .padding(.leading)
                Spacer()
            }
            
            VStack {
                
                VStack(alignment: .center) {
                    
                    Text("Hoje")
                        .font(.custom("Raleway-Semibold", size: 14))
                        .foregroundColor(.darkColor)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    Text("Essa conversa é sobre \(chatroom.mentorArea!)")
                        .padding(.all, 10)
                        .font(.custom("Raleway-Regular", size: 14))
                        .foregroundColor(.darkColor)
                        .multilineTextAlignment(.center)
                        .background(Color.bgcardColor)
                        .cornerRadius(10)
                        .padding(.top)
                    
                }
                
                ZStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        ScrollViewReader { reader in
                            LazyVStack(spacing: 0.5) {
                                ForEach(viewModel.messages) {  message in
                                    ChatBubble(direction: message.sender == Auth.auth().currentUser?.uid ? .right : .left) {
                                        Text(message.content)
                                            .padding(.all, 15)
                                            .foregroundColor(message.sender == Auth.auth().currentUser?.uid ? Color.lightColor :  Color.blackColor)
                                            .font(.custom("Raleway-Regular", size: 17))
                                            .background(message.sender == Auth.auth().currentUser?.uid ? Color.messageBlueColor : Color.grayColor)
                                        
                                        //                                    switch message.dataType {
                                        //                                    case
                                        //                                        .text(let userMessage):
                                        //                                        Text(userMessage)
                                        //                                            .padding(.all, 15)
                                        //                                            .foregroundColor(message .isMine ? lightColor :  blackColor)
                                        //                                            .font(.custom("Raleway-Regular", size: 17))
                                        //                                            .background(message.isMine ? messageBlueColor : greyColor)
                                        //                                    case
                                        //                                        .image(let imageIndex):
                                        //                                        Image(uiImage: ChatUI.pickerResult[imageIndex])
                                        //                                            .resizable()
                                        //                                            .frame(width: UIScreen.main.bounds.width - 70,
                                        //                                                   height: 200).aspectRatio(contentMode: .fill)
                                        //                                    }
                                    }
                                }
                                Rectangle()
                                    .frame(height: 50, alignment: .center)
                                    .foregroundColor(.systemLightDark).id(scrollToid)//padding from bottom
                                Scroll(reader: reader)
                            }
                        }
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            TextField("Mensagem", text: $fullText)
                                .frame(width: UIScreen.main.bounds.width - 70)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.titleColor.opacity(0.7), lineWidth: 2))
                                .font(.custom("Raleway-Regular", size: 17))
                            
                            Button(action: {
                                viewModel.sendMessage(messageContent: fullText, docId: chatroom.id)
                                //                            messageData.append(MessageData.init(isMine: true, dataType: .text(message: fullText)))
                                //                            messageData.append(MessageData.init(isMine: false, dataType: .text(message: "reply to: " + fullText)))
                                fullText = ""
                            }) {
                                Image(systemName: "paperplane")
                                    .foregroundColor(.lightColor)
                                    .padding(.all, 6)
                                    .background(Color.btnColor)
                                    .cornerRadius(8)
                                
                            }.disabled(fullText.isEmpty)
                        }
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom], 10)
                        .background(Color.bgcardColor)
                        
                    }
                }
                .padding(.top)
                
            }
        }
    }
}

struct ChatUI_Previews: PreviewProvider {
    static var previews: some View {
        ChatUI(chatroom: Chatroom(id: "", studentId: "", mentorId: "", studentName: "", mentorName: "", mentorArea: "", chatArea: ""))
    }
}
