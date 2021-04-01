//
//  UserViewModel.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 01/04/21.
//

import Foundation
import Firebase

class UserViewModel: ObservableObject, Identifiable {
    
    @Published var user: User
    
    private var db = Firestore.firestore()
    private var userAuth = Auth.auth().currentUser
    
    func fetchData() {
        
        if user != nil {
            db.collection("user").whereField("userID", isEqualTo: userAuth?.uid).addSnapshotListener({(snapshot,error) in
                guard let documents = snapshot?.documents
                else {
                    print("No docs returnd")
                    return
                }
                self.user = documents.map({docSnapshot -> User in
                    
                })
            })
        }
        
    }
}
