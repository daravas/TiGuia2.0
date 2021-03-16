//
//  TaskFavorite.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 11/03/21.
//

import Foundation
import FirebaseFirestore // (1)
import FirebaseFirestoreSwift

struct TaskFavorite: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var favorite: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}

#if DEBUG
let testDataFavoriteTasks = [
    TaskFavorite(title: "nomezinho da pagina", favorite: false),
    TaskFavorite(title: "engenharia tararan", favorite: false)
]
#endif
