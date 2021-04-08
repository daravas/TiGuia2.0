//
//  AreaMentor.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 01/12/20.
//

import Foundation
import SwiftUI

struct AreaMentorView: View {
    @State private var presented: Bool = false
    @State private var showAlert: Bool = false
    @ObservedObject var mentorCategoryVM = MentorCategoryViewModel()

    var category: Category
    //    static var areasEscolhidas: [Subcategory] = []
    static var mentor = Mentor()
    
    var columns = [
        // define number of caullum here
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 75.0)
            HStack {
                //título
                Text("Em quais áreas você tem conhecimento para mentorar?")
                    .font(.custom("Raleway-Bold", size: 30))
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(width: 350.0, alignment: .leading)
                    .foregroundColor(.darkColor)
                Spacer()
                
            }
            
            ScrollView {
                
                VStack {
                    LazyVGrid(columns: columns) {
                        ForEach(0..<category.subcategories.count, id: \.self) { count in
                            CardsAreaMentorView(category: category, count: count)
                        }
                    }
                    
                } .padding()
                
                Button(action: {
                    if !AreaMentorView.mentor.subAreas.isEmpty {
                       // self.mentorCategoryVM.addSubcategory(subcategories: AreaMentorView.mentor.subAreas)
                        self.presented.toggle()
                    } else {
                        self.showAlert.toggle()
                    }
                    
                }, label: {
                    Spacer()
                    Text("Continuar")
                        .font(.custom("Raleway-Bold", size: 18))
                        .foregroundColor(.lightColor)
                        .frame(alignment: .center)
                    Spacer()
                    
                }).padding()
                .clipped()
                .background(Color.btnColor)
                .cornerRadius(10)
                .padding()
                .shadow(radius: 10)
                .fullScreenCover(isPresented: $presented, content: {
                    SubAreaMentorView(subAreasEscolhidas: AreaMentorView.mentor.subAreas)
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Atenção!"), message: Text("Selecionar pelo menos uma área de conhecimento."), dismissButton: .default(Text("Ok")))
                }
            }
        }
        
    }
    
}

//struct AreaMentorView_Previews: PreviewProvider {
//    static var previews: some View {
//        AreaMentorView()
//    }
//}
