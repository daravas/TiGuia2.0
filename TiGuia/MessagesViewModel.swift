//
//  MessagesViewModel.swift
//  TiGuia
//
//  Created by Victor Vieira on 25/03/21.
//

import Foundation
import Firebase

class MessagesViewModel: ObservableObject{
    @Published var messages = [Message]()
    private var db = Firestore.firestore()
    private var user = Auth.auth().currentUser
    
    func sendMessage(messageContent: String, docId: String){
        if(user != nil){
            db.collection("mentoria").document(docId).collection("messages").addDocument(data: [
                "sentAt": Date(),
                "content": messageContent,
                "sender": user?.uid
            ])
        }
    }
    
    func fetchData(docId: String){
        if(user != nil){
            db.collection("mentoria").document(docId).collection("messages").order(by: "sentAt", descending: false).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else{
                    print("no documents")
                    return
                }
                self.messages = documents.map{ docSnapshot -> Message in
                    
                    
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let content = docSnapshot["content"] as? String ?? ""
                    let sender = docSnapshot["sender"] as? String ?? ""
                    return Message(id: docId, content: content, sender: sender)
                }
                
            })
            
            
        }
    }
    
    
    
}

