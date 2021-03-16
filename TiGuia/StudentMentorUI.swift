//
//  ButtonsUI.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 16/11/20.
//

import Foundation
import UIKit
import SwiftUI
import Firebase

// Apresentar proxima tela: Macro Area NAO ESTA SENDO USADA
//struct NextUI: UIViewControllerRepresentable {
//    
//    func makeUIViewController(context: Context) -> UIViewController {
//        return MacroAreaViewController()
//    }
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        
//    }
//}

// MARK: - Tela de estudante e mentor
struct StudentMentorUI: View {
    
    // @State var didTap = false
    @State var presented = false
    @State var presented2 = false
    //@State var selection: Int? = nil
    
    var image = ["person", "person.2"]
    var title = ["Aluno", "Mentor"]
    var descrip = ["Se você quer explorar a área da tecnologia e ainda tirar suas dúvidas com um mentor.", "Se você quer ajudar pessoas que têm interesse na sua área."]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 75.0)
            HStack {
                Text("Como você se identifica?")
                    .font(.custom("Raleway-Bold", size: 30))
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(width: 300.0, alignment: .leading)
                    .foregroundColor(.darkColor)
                Spacer()
            }
            
            VStack {
                // botao 1 - Aluno
                Button(action: {
                    self.presented.toggle()
                    Analytics.setUserProperty("Aluno", forName: "aluno_ou_mentor")
                
                }, label: {
                    HStack {
                        Image(systemName: "\(image[0])")
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
                            Text(title[0])
                                .font(.custom("Raleway-Bold", size: 24))
                                .padding([.leading, .bottom, .trailing], 5.0)
                                .foregroundColor(.lightColor)
                                .fixedSize(horizontal: false, vertical: true)

                            
                            Text(descrip[0])
                                .font(.custom("Raleway", size: 14))
                                .padding([.leading, .bottom, .trailing], 5.0)
                                .foregroundColor(.lightColor)
                                .fixedSize(horizontal: false, vertical: true)
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
                    //choices(selection: index)
                    MacroAreaUI()
                })
                
                // botao 2 - mentor
                Button(action: {
                    self.presented2.toggle()
                    Analytics.setUserProperty("Mentor", forName: "aluno_ou_mentor")
                
                }, label: {
                    HStack {
                        Image(systemName: "\(image[1])")
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
                            Text(title[1])
                                .font(.custom("Raleway-Bold", size: 24))
                                .padding([.leading, .bottom, .trailing], 5.0)
                                .foregroundColor(.lightColor)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text(descrip[1])
                                .font(.custom("Raleway", size: 14))
                                .padding([.leading, .bottom, .trailing], 5.0)
                                .foregroundColor(.lightColor)
                                .fixedSize(horizontal: false, vertical: true)
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
                .fullScreenCover(isPresented: $presented2, content: {
                    //choices(selection: index)
                    MacroAreaMentorUIView()
                })
                
                
            }.padding()
            
            // botoes de escolha entre aluno ou mentor
//            LazyVStack {
//                ForEach((0..<title.count)) { index in
//                    Button(action: {
//                        self.presented.toggle()
//
//                    }, label: {
//                        HStack {
//                            Image(systemName: "\(image[index])")
//                                .resizable()
//                                .padding(.all, 30.0)
//                                .scaledToFit()
//                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                .clipShape(Rectangle(), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
//                                .background(Color.lightColor)
//                                .cornerRadius(10)
//                                .foregroundColor(.orangeColor)
//                                .shadow(radius: 8)
//                            VStack(alignment: .leading) {
//                                Text(title[index])
//                                    .font(.custom("Raleway-Bold", size: 24))
//                                    .padding([.leading, .bottom, .trailing], 5.0)
//                                    .foregroundColor(.lightColor)
//
//                                Text(descrip[index])
//                                    .font(.custom("Raleway", size: 14))
//                                    .padding([.leading, .bottom, .trailing], 5.0)
//                                    .foregroundColor(.lightColor)
//
//                            }
//                            Spacer()
//                        }
//                        .padding()
//                        .clipped()
//                        .background(Color.btnColor)
//                        .cornerRadius(10)
//                    }).padding(.bottom, 20.0)
//                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                    .fullScreenCover(isPresented: $presented, content: {
//                        //choices(selection: index)
//                        //MacroAreaUI()
//                    })
//                }
//            }
//            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Spacer()
        }//.background(Color.backgroundColor)
    }
}

// preview da pagina
struct StudentMentorUI_Previews: PreviewProvider {
    static var previews: some View {
        StudentMentorUI()
    }
}
