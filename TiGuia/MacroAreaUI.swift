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
    @Environment(\.presentationMode) var presentationMode

    
    // @State var didTap = false
    @State private var presented = false
    var teste = Data().returnCategory() //acho que vai precisar apagar essa linha aqui. é que precisa iniciar a classe Data pra poder pegar o arrey de categorias
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Button(action: {
        
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .foregroundColor(.btnColor)
                        .frame(width: 15, height: 25)
                }.padding()
            }
           
            Spacer()
               // .frame(height: 75.0)
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
                //gambiarra. verificar depois
                    //ForEach((0..<Data.categories.count)){ index in
                        var category = Data.categories[0]
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
                        
                    //}
                    EmBreveUi()
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
    }
}

struct EmBreveUi: View{
    var body: some View{
        Button(action: {
            //self.presented.toggle()
        }, label: {
            HStack {
                Image("cadeado")
                    .resizable()
                    .padding(.all, 25.0)
                    .scaledToFit()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(Rectangle(), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                    .background(Color.lightColor)
                    .cornerRadius(10)
                    .foregroundColor(.orangeColor)
                  //  .shadow(radius: 8)
                VStack(alignment: .leading) {
                    Text("Em breve...")
                        .font(.custom("Raleway-Bold", size: 24))
                        .padding([.leading, .bottom, .trailing], 5.0)
                        .foregroundColor(.lightColor)
                    
                    Text("Fica ligado que já já tem mais áreas para explorar.")
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
            .background(Color.disabledBtnColor)
            .cornerRadius(10)
        }).padding(.bottom, 20.0)
        .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        //.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
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
