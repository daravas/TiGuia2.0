//
//  MentorCategoryRepository.swift
//  TiGuia
//
//  Created by Dara Vasconcelos on 29/03/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class MentorCategoryRepository: ObservableObject {
    var db = Firestore.firestore()
    
    @Published var categories = [Subcategory]()
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
//                let userId = Auth.auth().currentUser?.uid
//        
//                db.collection("categoria")
//                    .whereField("userId", isEqualTo: userId)
//                    .addSnapshotListener { (querySnapshot, error) in
//                        if let querySnapshot = querySnapshot {
//                            self.tasksFavorite = querySnapshot.documents.compactMap { document in
//                                do {
//                                    let x = try document.data(as: TaskFavorite.self)
//                                    return x
//                                }
//                                catch {
//                                    print(error)
//                                }
//                                return nil
//                            }
//                        }
//                    }
    }
    
    func addSubcategory(_ subcategory: Subcategory, userId:String) {
        //var userId = Auth.auth().currentUser?.uid ?? "default user"
        //adiciona categoria -> adiciona links -> adiciona mentor
        let docData: [String: Any] = [
            "content": subcategory.content,
            "image": subcategory.image,
            "title": subcategory.title
        ]
        let mentorData: [String:Any]=[
            "nome": "nome provisorio"
        ]
        var linkData: [String: Any]=[:]
        
        db.collection("categoria").document(subcategory.title).setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        for link in subcategory.links{
            linkData=[
                "title": link.titulo,
                "image": link.image,
                "url" : link.url ]
            
            db.collection("categoria/\(subcategory.title)/link").document(link.titulo).setData(linkData){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
        
        db.collection("categoria/\(subcategory.title)/mentor").document(userId).setData(mentorData)
        
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


