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
        let buttonColor = Color(red: 28/255, green: 118/255, blue: 144/255, opacity: 1.0)
        let lightColor = Color(red: 252/255, green: 252/255, blue: 252/255, opacity: 1.0)
        let orangeColor = Color(red: 251/255, green: 153/255, blue: 28/255, opacity: 1.0)
        let blackColor = Color(red: 32/255, green: 34/255, blue: 38/255, opacity: 1.0)
        let lightBlueColor = Color(red: 33/255, green: 158/255, blue: 188/255, opacity: 1.0)
        let messageBlueColor = Color(red: 31/255, green: 145/255, blue: 173/255, opacity: 1.0)
        let greyColor = Color(red: 224/255, green: 230/255, blue: 236/255, opacity: 1.0)
        let lightGreyColor = Color(red: 247/255, green: 249/255, blue: 250/255, opacity: 1.0)
        
        VStack{
        Button(action: {
//
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(buttonColor)
                .padding(.trailing, 370.0)
        }
        
        VStack(alignment: .leading) {
//            Spacer()
//            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Text("Mentoria com \(chatroom.mentorName!)")
                .font(.custom("Raleway-Bold", size: 30))
                .foregroundColor(lightBlueColor)
                .padding(.horizontal)
            Text("Professora de Computação")
                .font(.custom("Raleway-Regular", size: 18))
                .foregroundColor(blackColor)
                .padding(.horizontal)
            
            VStack {
                Text("Hoje")
                    .multilineTextAlignment(.center)
                    .background(lightColor)
                    .cornerRadius(3)
                    .padding(.top)
                    .padding(.leading,25)
                    .font(.custom("Raleway-Regular", size: 17))
                    .foregroundColor(blackColor)
                
                VStack {
                    
                    Text("Essa conversa é sobre \(chatroom.mentorArea!)")
                        .multilineTextAlignment(.center)
                        .background(lightGreyColor)
                        .cornerRadius(3)
                        .padding(.top)
                        .padding(.leading,40)
                        .font(.custom("Raleway-Regular", size: 18))
                        .foregroundColor(blackColor)
                    
                }
                
                
            }
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollViewReader { reader in
                        LazyVStack(spacing: 0.5) {
                            ForEach(viewModel.messages) {  message in
                                ChatBubble(direction: message.sender == Auth.auth().currentUser?.uid ? .right : .left) {
                                    Text(message.content)
                                        .padding(.all, 15)
                                        .foregroundColor(message.sender == Auth.auth().currentUser?.uid ? lightColor :  blackColor)
                                        .font(.custom("Raleway-Regular", size: 17))
                                        .background(message.sender == Auth.auth().currentUser?.uid ? messageBlueColor : greyColor)
                                    
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
                                .foregroundColor(Color.white).id(scrollToid)//padding from bottom
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
                            .font(.custom("Raleway-Regular", size: 17))
                            .border(lightBlueColor)
                            .cornerRadius(3)
                            .padding(.trailing)
                        Spacer()
                            .frame(width: -10.0)
                        
                        Button(action: {
                            viewModel.sendMessage(messageContent: fullText, docId: chatroom.id)
//                            messageData.append(MessageData.init(isMine: true, dataType: .text(message: fullText)))
//                            messageData.append(MessageData.init(isMine: false, dataType: .text(message: "reply to: " + fullText)))
                            fullText = ""
                        }) {
                            Image(systemName: "paperplane")
                                .foregroundColor(lightColor)
                                .padding(.all, 6)
                                .background(buttonColor)
                                .cornerRadius(3)
                            
                        }.disabled(fullText.isEmpty)
                    }
                    .padding([.leading, .trailing], 10)
                    .padding([.top, .bottom], 10)
                    .background(lightColor)
                    
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
