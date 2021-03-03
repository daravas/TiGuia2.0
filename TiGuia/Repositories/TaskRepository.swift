//
//  TaskRepository.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 02/03/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import Resolver

class FirestoreTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
  var db = Firestore.firestore()
  
  @Injected var authenticationService: AuthenticationService // (1)
  var tasksPath: String = "tasks" // (2)
  var userId: String = "unknown"
  
  private var cancellables = Set<AnyCancellable>()
  
  override init() {
    super.init()
    
    authenticationService.$user // (3)
      .compactMap { user in
        user?.uid // (4)
      }
      .assign(to: \.userId, on: self) // (5)
      .store(in: &cancellables)
    
    // (re)load data if user changes
    authenticationService.$user // (6)
      .receive(on: DispatchQueue.main) // (7)
      .sink { user in
        self.loadData() // (8)
      }
      .store(in: &cancellables)
  }
  
  private func loadData() {
    db.collection(tasksPath)
      .whereField("userId", isEqualTo: self.userId) // (9)
      .order(by: "createdTime")
      .addSnapshotListener { (querySnapshot, error) in
        if let querySnapshot = querySnapshot {
          self.tasks = querySnapshot.documents.compactMap { document -> Task? in
            try? document.data(as: Task.self)
          }
        }
      }
  }
  
  func addTask(_ task: Task) {
    do {
      var userTask = task
      userTask.userId = self.userId // (10)
      let _ = try db.collection(tasksPath).addDocument(from: userTask)
    }
    catch {
      fatalError("Unable to encode task: \(error.localizedDescription).")
    }
  }
  
  func removeTask(_ task: Task) {
    if let taskID = task.id {
      db.collection(tasksPath).document(taskID).delete { (error) in
        if let error = error {
          print("Unable to remove document: \(error.localizedDescription)")
        }
      }
    }
  }
  
  func updateTask(_ task: Task) {
    if let taskID = task.id {
      do {
        try db.collection(tasksPath).document(taskID).setData(from: task)
      }
      catch {
        fatalError("Unable to encode task: \(error.localizedDescription).")
      }
    }
  }
}



class BaseTaskRepository {
  @Published var tasks = [Task]()
}

protocol TaskRepository: BaseTaskRepository {
  func addTask(_ task: Task)
  func removeTask(_ task: Task)
  func updateTask(_ task: Task)
}
