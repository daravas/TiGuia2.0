//
//  User.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 01/04/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    
    @DocumentID var id: String?
    
    var userID: String
    var isSigned: Bool
}
