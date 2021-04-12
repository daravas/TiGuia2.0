//
//  ChatUIApp.swift
//  TiGuia
//
//  Created by Palloma Ramos on 23/11/20.
//

import SwiftUI

struct ChatUIApp: App {
    var body: some Scene {
        WindowGroup {
            ChatUI(chatroom: Chatroom(id: "", studentId: "", mentorId: "", studentName: "", mentorName: "", mentorArea: "", chatArea: ""))
        }
    }
}
struct ChatUIApp_Previews: PreviewProvider {
    static var previews: some View {
        ChatUI(chatroom: Chatroom(id: "", studentId: "", mentorId: "", studentName: "", mentorName: "", mentorArea: "", chatArea: ""))
    }
    
}
