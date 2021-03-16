
//  TaskRepository.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 02/03/21.


import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FavoriteTaskRepository: ObservableObject {
    var db = Firestore.firestore()
    
    @Published var tasksFavorite = [TaskFavorite]()
    //  @Injected var authenticationService: AuthenticationService // (1)

    private var cancellables = Set<AnyCancellable>()
    
    //  override init() {
    //    super.init()
    
    //    authenticationService.$user // (3)
    //      .compactMap { user in
    //        user?.uid // (4)
    //      }
    //      .assign(to: \.userId, on: self) // (5)
    //      .store(in: &cancellables)
    
    //    // (re)load data if user changes
    //    authenticationService.$user // (6)
    //      .receive(on: DispatchQueue.main) // (7)
    //      .sink { user in
    //        self.loadData() // (8)
    //      }
    //      .store(in: &cancellables)
    //  }
    
    init() {
        loadData()
    }
    
    private func loadData() {
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("tasksFavorite")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.tasksFavorite = querySnapshot.documents.compactMap { document in
                        do {
                            let x = try document.data(as: TaskFavorite.self)
                            return x
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
            }
    }

  func addTask(_ task: TaskFavorite) {
    do {
        var addedTask = task
        addedTask.userId = Auth.auth().currentUser?.uid
      let _ = try db.collection("tasksFavorite").addDocument(from: addedTask)
    }
    catch {
      fatalError("Unable to encode task: \(error.localizedDescription).")
    }
  }

    func updateTask(_ task: TaskFavorite) {
        if let taskID = task.id {
            do {
                try db.collection("tasksFavorite").document(taskID).setData(from: task)
            }
            catch {
                fatalError("Unable to encode task: \(error.localizedDescription).")
            }
        }
    }
    
//    func removeTask(_ task: TaskFavorite) {
//        if let taskID = task.id {
//            db.collection("tasksFavorite").document(taskID).delete { (error) in
//                if let error = error {
//                    print("Unable to remove document: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
}



//class BaseTaskRepository {
//  @Published var tasksFavorite = [TaskFavorite]()
//}
//
//protocol TaskRepository: BaseTaskRepository {
//  func addTask(_ task: Task)
//  func removeTask(_ task: Task)
//  func updateTask(_ task: Task)
//}

