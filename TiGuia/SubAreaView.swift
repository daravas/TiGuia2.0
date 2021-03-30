//
//  SubArea.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 02/12/20.
//

import Foundation
import SwiftUI

struct SubAreaMentorView: View {
    @State private var favorito: Bool = false
    @State private var presented: Bool = false
    @ObservedObject var mentorCategoryVM = MentorCategoryViewModel()

    
    var category = Data().returnCategory()
    var subAreasEscolhidas: [Subcategory]
        
    
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
                ForEach(0..<subAreasEscolhidas.count, id: \.self) { index in
                    if !subAreasEscolhidas[index].subcategories.isEmpty {
                        HStack {
                            Text(subAreasEscolhidas[index].title)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                                .font(.custom("Raleway-Bold", size: 20))
                                .foregroundColor(.titleColor)
                            Spacer()
                        }
                        VStack {
                            LazyVGrid(columns: columns) {
                                ForEach(0..<subAreasEscolhidas[index].subcategories.count, id: \.self) { count in
                                    CardsSubAreaMentorView(category: subAreasEscolhidas[index], count: count)
                                }
                            }
                            
                        } .padding()
                    }
                }
                
                Button(action: {
                    self.mentorCategoryVM.addSubcategory(subcategories: AreaMentorView.mentor.subAreas)
                    self.presented.toggle()
                    
                }, label: {
                    Spacer()
                    Text("Finalizar")
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
                    NextContentUI().ignoresSafeArea(.all)
                    //ConteudoMentorView(subAreasEscolhidas: AreaMentorView.mentor.subAreas)
                })
                
            }
        }
        
    }
    
}

struct NextContentUI: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NextContentUI>) -> UIViewController {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // swiftlint:disable force_cast
        let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarMentor_vc") as! UITabBarController
        // swiftlint:enable force_cast
        return mainViewController
        
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct SubAreaMentorView_Previews: PreviewProvider {
    static var previews: some View {
        SubAreaMentorView(subAreasEscolhidas: AreaMentorView.mentor.subAreas)
    }
}
