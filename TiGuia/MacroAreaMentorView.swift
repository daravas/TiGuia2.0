//
//  areaMentor.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 30/11/20.
//

import Foundation
import UIKit
import SwiftUI
import Firebase

// MARK: - Area Mentor
struct MacroAreaMentorUIView: View {
//    @Environment(\.presentationMode) var presentationMode
    
    // @State var didTap = false
    @State private var presented = false
    var teste = Data() //acho que vai precisar apagar essa linha aqui. é que precisa iniciar a classe Data pra poder pegar o arrey de categorias
    init(){
        if (!UserDefaults.standard.bool(forKey: "eMentor")){
            Analytics.setUserProperty("Mentor", forName: "aluno_ou_mentor")
            UserDefaults.standard.set(true, forKey: "eMentor")
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
//            HStack{
//                Button(action: {
//
//                    self.presentationMode.wrappedValue.dismiss()
//                }) {
//                    Image(systemName: "chevron.backward")
//                        .resizable()
//                        .foregroundColor(.btnColor)
//                        .frame(width: 15, height: 25)
//                }.padding()
//            }
            Spacer()
                .frame(height: 75.0)
            HStack {
                Text("O que você deseja mentorar?")
                    .font(.custom("Raleway-Bold", size: 30))
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(width: 300.0, alignment: .leading)
                    .foregroundColor(.darkColor)
                Spacer()
            }
            // scrollview com as macroareas
            ScrollView {
                LazyVStack {
                   // ForEach((0..<Data.categories.count)){ index in
                        var category: Category = Data.categories[0]
                        Button(action: {
                            self.presented.toggle()
                            UserDefaults.standard.set(true, forKey: "macroAreaSelected")
                        }, label: {
                            HStack {
                                Image(systemName: category.image!)
                                    .resizable()
                                    .padding(.all, 30.0)
                                    .scaledToFit()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .clipShape(Rectangle(), style: FillStyle())
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
                        .shadow(radius: 10)
                        .fullScreenCover(isPresented: $presented, content: {
                            AreaMentorView(category: Data.categories[0])
                        })
                        
                    }
                    EmBreveUiMentor()
                }
                .padding(.all)
                Spacer()
            }
        }
    }
//}

struct EmBreveUiMentor: View{
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
                    
                    Text("Fica ligado que já já tem mais áreas para ajudar.")
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
//struct NextMentorUI: UIViewControllerRepresentable {
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        return AreaMentorView()
//    }
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//
//    }
//}

// preview
struct AreaMentorUI_Previews: PreviewProvider {
    static var previews: some View {
        MacroAreaMentorUIView()
    }
}
