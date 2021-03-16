//
//  TaskFavoriteViewModel.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 11/03/21.
//

import Foundation
import Combine

class FavoriteViewModel: ObservableObject, Identifiable {
    @Published var taskRepository = FavoriteTaskRepository()
    @Published var taskFavorite: TaskFavorite
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: TaskFavorite) {
        
        self.taskFavorite = task
        
        $taskFavorite
            .map { task in
                task.favorite ? "star.fill" : "star"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
        
        $taskFavorite
            .compactMap { task in
                task.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $taskFavorite
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { task in
                self.taskRepository.updateTask(task)
            }
            .store(in: &cancellables)
    }
    
}


