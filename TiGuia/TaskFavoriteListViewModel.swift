//
//  TaskFavoriteListViewModel.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 11/03/21.
//

import Foundation
import Combine

class FavoriteListViewModel: ObservableObject {
    @Published var taskFavoriteRepository = FavoriteTaskRepository()
    @Published var taskFavoriteViewModels = [FavoriteViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        taskFavoriteRepository.$tasksFavorite
            .map { tasks in
                tasks.map { task in
                    FavoriteViewModel(task: task)
                }
            }
            .assign(to: \.taskFavoriteViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func addTask(task: TaskFavorite) {
        taskFavoriteRepository.addTask(task)
    }
}
