//
//  ChatroomViewModel.swift
//  TiGuia
//
//  Created by Victor Vieira on 24/03/21.
//

import Foundation
import Firebase

class ChatroomViewModel: ObservableObject{
    @Published var chatrooms = [Chatroom]()
    @Published var newChatrooms = [Chatroom]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func fetchData(){
        if(user != nil){
            db.collection("mentoria").whereField("users", arrayContains: user!.uid).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("No docs returnd")
                    return
                }
                self.chatrooms = documents.map({docSnapshot -> Chatroom in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let studentId = data["studentId"] as? String ?? ""
                    let mentorId = data["mentorId"] as? String ?? ""
                    let studentName = data["studentName"] as? String ?? ""
                    let mentorName = data["mentorName"] as? String ?? ""
                    let mentorArea = data["mentorArea"] as? String ?? ""
                    let chatArea = data["chatArea"] as? String ?? ""
                    return Chatroom(id: docId, studentId: studentId, mentorId: mentorId, studentName: studentName, mentorName: mentorName, mentorArea: mentorArea, chatArea: chatArea)
                })
                
            })
        }
    }
    
    func fetchStudents(){
        if(user != nil){
            db.collection("mentoria").whereField("mentorId", isEqualTo: "").addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("No docs returnd")
                    return
                }
                self.newChatrooms = documents.map({docSnapshot -> Chatroom in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let studentId = data["studentId"] as? String ?? ""
                    let mentorId = data["mentorId"] as? String ?? ""
                    let studentName = data["studentName"] as? String ?? ""
                    let mentorName = data["mentorName"] as? String ?? ""
                    let mentorArea = data["mentorArea"] as? String ?? ""
                    let chatArea = data["chatArea"] as? String ?? ""
                    return Chatroom(id: docId, studentId: studentId, mentorId: mentorId, studentName: studentName, mentorName: mentorName, mentorArea: mentorArea, chatArea: chatArea)
                })
                
            })
        }
        
        
        
    }

    
    
        
    func createChatroom(studentId: String, studentName:String, chatArea: String, message: String, handler: @escaping () -> Void?){
            if(user != nil){
                var collection = db.collection("mentoria").addDocument(data: [
                    "studentId": studentId,
                    "studentName": studentName,
                    "chatArea": chatArea,
                    "users": [user!.uid],
                    "mentorId": ""
                    
                ]){err in
                    if let err = err {
                        print("error adding document:\(err)")
                    }
                    else{
                        handler()
                    }
                    
                }
                var messagesViewModel = MessagesViewModel()
                messagesViewModel.sendMessage(messageContent: message, docId: collection.documentID)
                
            }
            
        }
        
        func joinChatroom(id: String, mentorId: String, mentorName: String, mentorArea: String, handler: @escaping () -> Void?){
            if(user != nil){
                db .collection("mentoria").document(id).getDocument(){(snapshot, error) in
                    if let error = error {
                        print("error getting documents: \(error)")
                    }
                    else {
                        self.db.collection("mentoria").document(snapshot!.documentID).updateData([
                            "users": FieldValue.arrayUnion([self.user!.uid]),
                            "mentorId": mentorId,
                            "mentorName": mentorName,
                            "mentorArea": mentorArea
                            
                        ])
                        handler()
                    }
                }
            }
        }
        
        
    }

