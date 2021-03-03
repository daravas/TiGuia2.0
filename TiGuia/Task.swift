//
//  Task.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 02/03/21.
//

import Foundation
import FirebaseFirestore // (1)
import FirebaseFirestoreSwift

enum TaskPriority: Int, Codable {
  case high
  case medium
  case low
}

struct Task: Codable, Identifiable {
  @DocumentID var id: String?
  var title: String
  var priority: TaskPriority
  var completed: Bool
  @ServerTimestamp var createdTime: Timestamp?
  var userId: String?
}
