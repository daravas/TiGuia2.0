//
//  Chatroom.swift
//  TiGuia
//
//  Created by Victor Vieira on 24/03/21.
//

import Foundation

struct Chatroom: Codable, Identifiable{
    var id: String
    var studentId: String
    var mentorId: String?
    var studentName: String
    var mentorName: String?
    var mentorArea: String?
    var chatArea: String
}
