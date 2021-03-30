//
//  MentorCategoryViewModel.swift
//  TiGuia
//
//  Created by Dara Vasconcelos on 29/03/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class MentorCategoryViewModel: ObservableObject, Identifiable {
    @Published var mentorCategoryRepository = MentorCategoryRepository()
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
//        self.taskFavorite = task
//
//        $taskFavorite
//            .map { task in
//                task.favorite ? "star.fill" : "star"
//            }
//            .assign(to: \.completionStateIconName, on: self)
//            .store(in: &cancellables)
//
//        $taskFavorite
//            .compactMap { task in
//                task.id
//            }
//            .assign(to: \.id, on: self)
//            .store(in: &cancellables)
//
//        $taskFavorite
//            .dropFirst()
//            .debounce(for: 0.8, scheduler: RunLoop.main)
//            .sink { task in
//                self.taskRepository.updateTask(task)
//            }
//            .store(in: &cancellables)
    }
    func addSubcategory(subcategories: [Subcategory]) {
        var userId = Auth.auth().currentUser?.uid ?? "default user"
        for subcategory in subcategories{
            mentorCategoryRepository.addSubcategory(subcategory,userId: userId)
        }
    }
    
}


