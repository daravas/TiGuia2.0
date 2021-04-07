//
//  MacroArea.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 17/11/20.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - Macro Area
struct MacroAreaUI: View {
    
    // @State var didTap = false
    @State private var presented = false
    var teste = Data() //acho que vai precisar apagar essa linha aqui. é que precisa iniciar a classe Data pra poder pegar o arrey de categorias
    var image = ["desktopcomputer", "paintbrush", "desktopcomputer", "paintbrush", "desktopcomputer", "paintbrush"]
    var title = ["Computação", "Design", "Computação", "Design", "Computação", "Design"]
    var descrip = ["Estuda as técnicas, metodologias, instrumentos computacionais e aplicações tecnológicas...", "Desenvolve conceitos visuais para peças gráficas e materiais. Se preocupa com funcionalidade...", "Estuda as técnicas, metodologias, instrumentos computacionais e aplicações tecnológicas...", "Desenvolve conceitos visuais para peças gráficas e materiais. Se preocupa com funcionalidade...", "Estuda as técnicas, metodologias, instrumentos computacionais e aplicações tecnológicas...", "Desenvolve conceitos visuais para peças gráficas e materiais. Se preocupa com funcionalidade..."]
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 75.0)
            HStack {
                Text("O que você deseja explorar?")
                    .font(.custom("Raleway-Bold", size: 30))
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(width: 280.0, alignment: .leading)
                    .foregroundColor(.darkColor)
                Spacer()
            }
            // scrollview com as macroareas
            ScrollView{
                LazyVStack {
                    ForEach((0..<Data.categories.count)){ index in
                        var category = Data.categories[index]
                        Button(action: {
                            self.presented.toggle()
                            UserDefaults.standard.set(true, forKey: "macroAreaSelected")

                        }, label: {
                            HStack {
                                Image(systemName: category.image!)
                                    .resizable()
                                    .padding(.all, 30.0)
                                    .scaledToFit()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .clipShape(Rectangle(), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                                    .background(Color.lightColor)
                                    .cornerRadius(10)
                                    .foregroundColor(.orangeColor)
                                    .shadow(radius: 8)
                                VStack(alignment: .leading) {
                                    Text(category.title)
                                        .font(.custom("Raleway-Bold", size: 24))
                                        .padding([.leading, .bottom, .trailing], 5.0)
                                        .foregroundColor(.lightColor)
                                    
                                    Text(category.content)
                                        .font(.custom("Raleway", size: 14))
                                        .lineLimit(3)
                                        .padding([.leading, .bottom, .trailing], 5.0)
                                        .foregroundColor(.lightColor)
                                        .lineSpacing(1)

                                    
                                }
                                Spacer()
                            }
                            .padding()
                            .clipped()
                            .background(Color.btnColor)
                            .cornerRadius(10)
                        }).padding(.bottom, 20.0)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .fullScreenCover(isPresented: $presented, content: {
                            NextTrailUI().ignoresSafeArea(.all)
                        })
                        
                    }
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
    }
}

struct NextTrailUI: UIViewControllerRepresentable {
    //var teste: Int
    func makeUIViewController(context: UIViewControllerRepresentableContext<NextTrailUI>) -> UIViewController {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // swiftlint:disable force_cast
        let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBar_vc") as! UITabBarController
        // swiftlint:enable force_cast
        return mainViewController
        
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

// preview
struct MacroAreaUI_Previews: PreviewProvider {
    static var previews: some View {
        MacroAreaUI()
    }
}
