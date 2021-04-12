//
//  Message.swift
//  TiGuia
//
//  Created by Victor Vieira on 25/03/21.
//

import Foundation


struct Message: Codable, Identifiable{
    var id: String?
    var content: String
    var sender: String
}
