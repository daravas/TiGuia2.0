//
//  UserViewModel.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 01/04/21.
//

import Foundation
import Firebase

class UserViewModel: ObservableObject, Identifiable {
    
    @Published var user = [User]()
    
    private var db = Firestore.firestore()
    private var userAuth = Auth.auth().currentUser
    
    
    
   
    func sendData(isSigned: Bool){
        //if(db.collection("user").whereField("userID", isEqualTo: userAuth!.uid).getDocuments())
        
        if (user != nil){
            db.collection("user").whereField("userID", isEqualTo: userAuth!.uid).getDocuments(){ (snapshot, error) in
                if let error = error {
                    print("error getting documents: \(error)")
                }
                else {
                
                    guard let documents = snapshot?.documents else{
                        self.db.collection("user").addDocument(data: [
                            "userID": self.userAuth!.uid,
                            "isSigned": isSigned
                        ])
                        return
                    }                    
                    for document in snapshot!.documents {
                        self.db.collection("user").document(document.documentID).updateData([
                            "isSigned": isSigned
                        ])
                    }
                    if (self.user.count == 0){
                        self.createData(isSigned: isSigned)
                    }
                }
                                
                
                
            }
        }
    }
    
    
    func createData(isSigned: Bool) {
        if (user != nil) {
            db.collection("user").addDocument(data: [
                "userID": self.userAuth!.uid,
                "isSigned": isSigned
            ])
        }
    }
    
    func fetchData(isSigned: Bool) {
        
        if user != nil {
            db.collection("user").whereField("userID", isEqualTo: userAuth?.uid).addSnapshotListener({(snapshot,error) in
                guard let documents = snapshot?.documents
                else {
                    print("No docs returnd")
                    return
                }
                
                self.user = documents.map({docSnapshot -> User in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let userID = data["userID"] as? String ?? ""
                    let isSigned = data["isSigned"] as! Bool
                    
                    return User(id: docId, userID: self.userAuth!.uid, isSigned: isSigned)
                })
                if (documents.count == 0){
                    self.createData(isSigned: isSigned)
                }
            })
        }
        
    }
}
