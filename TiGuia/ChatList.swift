//
//  ChatList.swift
//  TiGuia
//
//  Created by Victor Vieira on 25/03/21.
//

import SwiftUI
import Firebase

struct ChatList: View {
    @ObservedObject var chatVireModel = ChatroomViewModel()
    let buttonColor = Color(red: 28/255, green: 118/255, blue: 144/255, opacity: 1.0)
    let lightColor = Color(red: 252/255, green: 252/255, blue: 252/255, opacity: 1.0)
    let orangeColor = Color(red: 251/255, green: 153/255, blue: 28/255, opacity: 1.0)
    let blackColor = Color(red: 32/255, green: 34/255, blue: 38/255, opacity: 1.0)
    let lightBlueColor = Color(red: 33/255, green: 158/255, blue: 188/255, opacity: 1.0)
    let messageBlueColor = Color(red: 31/255, green: 145/255, blue: 173/255, opacity: 1.0)
    let greyColor = Color(red: 224/255, green: 230/255, blue: 236/255, opacity: 1.0)
    let lightGreyColor = Color(red: 247/255, green: 249/255, blue: 250/255, opacity: 1.0)
    init(){
        chatVireModel.fetchData()
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Mentores")
                    .font(.custom("Raleway-Bold", size: 30))
                    .foregroundColor(lightBlueColor)
                    .padding(.horizontal)
                Text("Mentores que aceitaram suas solicitações")
                    .font(.custom("Raleway-Regular", size: 18))
                    .foregroundColor(blackColor)
                    .padding(.horizontal)
                Text(Auth.auth().currentUser!.uid)

            List(chatVireModel.chatrooms){ chatroom in
                NavigationLink(destination: ChatUI(chatroom: chatroom).navigationBarHidden(true)){
                    VStack{
                    HStack{
                        Text(chatroom.mentorName ?? "Procurando mentor")
                        Spacer()
                    }
                       
                    }
                            
                                            
                }
                    
                }
            }
            //.navigationTitle("Mentoria")
            
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
