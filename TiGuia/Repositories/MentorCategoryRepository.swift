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
    let userId = Auth.auth().currentUser?.uid

    @Published var categories = [MentorSubcategory]()
    @Published var links = [Link]()
    @Published var titles: [String] = []
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
        //fetchCategories(userId: userId!)
    }
    
    func fetchCategories(userId:String){
        var list: [String] = []
            db.collection("categoria").whereField("mentores", arrayContains: userId).addSnapshotListener({(snapshot, error) in
                  guard let documents = snapshot?.documents else {
                      print("No docs returnd")
                      return
                  }
                  self.categories = documents.map({docSnapshot -> MentorSubcategory in
                      let data = docSnapshot.data()
                      let docId = docSnapshot.documentID
                      let title = data["title"] as? String ?? ""
                      let content = data["content"] as? String ?? ""
                      let image = data["image"] as? String ?? ""
                    //let links = self.fetchLinks(docId: docId)
                    list.append(title)
                    return MentorSubcategory(title: title, content: content,image: image, docId: docId)
                  })
                self.titles = list
              })
          
    }
    
    func fetchLinks(docId:String){
        /*db.collection("cities").whereField("capital", isEqualTo: true)
         .getDocuments() { (querySnapshot, err) in
             if let err = err {
                 print("Error getting documents: \(err)")
             } else {
                 for document in querySnapshot!.documents {
                     print("\(document.documentID) => \(document.data())")
                 }
             }
     }*/
        
        db.collection("categoria").document(docId).collection("link").addSnapshotListener({(snapshot, error) in
              guard let documents = snapshot?.documents else {
                  print("No docs returnd")
                  return
              }
              self.links = documents.map({docSnapshot -> Link in
                  let data = docSnapshot.data()
                  let docId = docSnapshot.documentID
                  let title = data["title"] as? String ?? ""
                  let url = data["url"] as? String ?? ""
                  let image = data["image"] as? String ?? ""
                print(title)
                  return Link(titulo: title, url: url, image: image)
              })
              
          })
        
    }
        

    
    func addSubcategory(_ subcategory: Subcategory, userId:String) {
       
        let docData: [String: Any] = [
            "content": subcategory.content,
            "image": subcategory.image,
            "title": subcategory.title,
            "mentores": [userId]
        ]
        
        var linkData: [String: Any]=[:]
        
       
        db.collection("categoria").document(subcategory.title).getDocument(){(snapshot, error) in
            if let error = error {
                print("error getting documents: \(error)")
            }
            else {
                if snapshot?.exists ?? false{
                    self.db.collection("categoria").document(snapshot!.documentID).updateData([
                        "mentores": FieldValue.arrayUnion([userId]),
                        "content": subcategory.content,
                        "image": subcategory.image,
                        "title": subcategory.title
                    ])
                }else{
                    self.db.collection("categoria").document(subcategory.title).setData(docData) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                }
                
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
                    print("Document Link successfully written!")
                }
            }
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


