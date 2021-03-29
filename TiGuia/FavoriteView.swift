//
//  FavoriteView.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 11/03/21.
//

import Foundation
import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var taskFavoriteListVM = FavoriteListViewModel()
    
    @State var presentAddNewItem = false
    @State var showSignInForm = false
    
    var body: some View {
        VStack {
            NavigationView {
                GeometryReader { geometry in
                    
                    VStack(alignment: .leading) {
                        
                        Image("favorito")
                            .resizable()
                            .scaledToFill()
                            .frame(height: (geometry.size.height/3) + 35, alignment: .center)
                            .edgesIgnoringSafeArea(.top)
                            .padding(.bottom, -(geometry.safeAreaInsets.top))
                        
                        VStack {
                            HStack{
                                Text("Favoritos")
                                    .font(.custom("Raleway-Bold", size: 30))
                                    .foregroundColor(.titleColor)
                                Spacer()
                            }.padding([.top, .leading, .trailing])
                        }
                        .background(RoundedCorners(tl: 25, tr: 25, bl: 0, br: 0).fill(Color.backgroundColor)) // ta mostrando o fundo de cores diferentes
                        .clipped()
                        .shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 15, x: 0.0, y: -5.0)
                        .offset(y: -35)
                        
                        List {
                            ForEach (taskFavoriteListVM.taskFavoriteViewModels) { taskFavoriteCellVM in // (3)
                                TaskCell(taskFavoriteCellVM: taskFavoriteCellVM) // (6)
                            }
                            if presentAddNewItem {
                                TaskCell(taskFavoriteCellVM: FavoriteViewModel(task: TaskFavorite(title: "", favorite: false))) { task in
                                    self.taskFavoriteListVM.addTask(task: task)
                                    self.presentAddNewItem.toggle()
                                }
                            }
                            
                        }
                        .sheet(isPresented: $showSignInForm) {
                            SignInView(userAuth: UserAuth())
                        }
                        .navigationBarItems(trailing: Button( action: {
                            self.showSignInForm.toggle()
                        }, label: {
                            Image(systemName: "person.circle")
                        }))
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .navigationBarTitle("")
                    
                    
                }
                
            }
            Button(action:{
                
                self.presentAddNewItem.toggle()
                
                
            }) {
                Text("add new favorite")
            } .padding()
        }
    }
    
}

struct TaskCell: View {
    
    @ObservedObject var taskFavoriteCellVM: FavoriteViewModel
    var onCommit: (TaskFavorite) -> Void = { _ in }
    
    var body: some View {
        TextField("Digite aqui um negocio", text: $taskFavoriteCellVM.taskFavorite.title, onCommit: {
            self.onCommit(self.taskFavoriteCellVM.taskFavorite)
        })
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
