//
//  SubcategoryView.swift
//  TiGuia
//
//  Created by Dara Vasconcelos on 24/11/20.
//

import Foundation
import Firebase

import SwiftUI
//titulo, conteúdo, links, cards subcategorias, btn favorito
public struct SubcategoryView: View {
    @State var favorito: Bool
    @State private var presented: Bool = false
    @State var showModal: Bool = false
    @State var completed: Bool = false
    @State var isExpanded: Bool = false
    @State var truncated: Bool = false
    @State private var showSignInForm = false
    
    @ObservedObject var userAuth = UserAuth()
    
    //var category = Data().returnCategory()
    
    //var index:Int
    
    var category:Subcategory
    
    //static var favorite = Favorites()
    //var index:Int
    
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.backgroundColor.opacity(0.8), Color.backgroundColor.opacity(0.2)]), startPoint: .center, endPoint: .top)
    }
    
    private func determineTruncation(_ geometry: GeometryProxy) {
        // Calculate the bounding box we'd need to render the
        // text given the width from the GeometryReader.
        let total = self.category.content.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 16)],
            context: nil
        )
        
        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }
    
    public var body: some View {
        
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .center) {
                    GeometryReader { gmt in
                        Image(category.imageCapa!)
                            .resizable()
                            .scaledToFill()
                            .frame(height: geometry.size.height, alignment: .center)
                            //.edgesIgnoringSafeArea(.top)
                            .offset(y: gmt.frame(in: .global).minY > 0 ? -gmt.frame(in: .global).minY : 0)
                        
                    }.frame(height: geometry.size.height / 4 + 30)
                    
                }
                
                VStack {
                    //
                    //MARK: -Header - titulo + botao de favoritos
                    //
                    HStack(alignment: .top) {
                        //título
                        Text(category.title)
                            .foregroundColor(.titleColor)
                            .font(.custom("Raleway-Bold", size: 30))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            self.favorito.toggle()
                            if (self.favorito) {
                                Data.favorite.addSubcategory(subcategory: category)
                            } else {
                                Data.favorite.removeSubcategory(subcategory: category)
                            }
                            category.favorite = favorito
                            
                        }, label: {
                            Image(systemName: self.favorito == true ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .padding(10)
                                .background(Color.btnColor)
                                .foregroundColor(.lightColor)
                                .frame(width: 48, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10)
                        })
                        .padding([.top, .trailing])
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        //.offset(y: -10) // realmente necessario?
                        
                    }//.padding()
                    
                    //
                    //MARK: -inicio do conteúdo
                    //
                    
                    ScrollView{
                        
                        ZStack(alignment: .bottom) {
                            
                            VStack {
                                Text(category.content)
                                    .font(.custom("Raleway-Regular", size: 15))
                                    .multilineTextAlignment(.leading)
                                    //.padding()
                                    .foregroundColor(.darkColor)
                                    .lineLimit(self.isExpanded ? nil : 10)
                                    .lineSpacing(3)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .background(GeometryReader { geometry in
                                        Color.clear.onAppear {
                                            self.determineTruncation(geometry)
                                        }
                                    })
                                if self.truncated {
                                    Spacer(minLength: self.isExpanded ? 30 : 20)
                                }
                            }.padding([.top, .leading, .trailing])
                            
                            if self.truncated {
                                Button(action: {
                                    if !isExpanded {
                                        //self.limit = 200
                                        //self.isExpanded.toggle()
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            self.isExpanded.toggle()
                                        }
                                    } else {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            self.isExpanded.toggle()
                                        }
                                        //                                    self.limit = 10
                                        //                                    self.isExpanded.toggle()
                                    }
                                }, label: {
                                    if !isExpanded {
                                        ZStack (alignment: .bottom){
                                            Rectangle().fill(gradient)
                                                .frame(width: geometry.size.width, height: 50)
                                            
                                            HStack {
                                                Spacer()
                                                Text("Continuar lendo")
                                                    .font(.custom("Raleway-Regular", size: 15))
                                                    .foregroundColor(.btnColor)
                                                Spacer()
                                            }.padding([.leading, .trailing])
                                            
                                        }
                                    } else {
                                        VStack {
                                            HStack {
                                                //Spacer()
                                                Text("Ver menos")
                                                    .font(.custom("Raleway-Regular", size: 15))
                                                    .foregroundColor(.btnColor)
                                                    .padding(.top)
                                                Spacer()
                                            }.padding(.horizontal)
                                        }
                                        
                                    }
                                })
                                
                            }
                        }
                        
                        
                        
                        
                        
                        HStack{
                            Text("Links úteis")
                                .multilineTextAlignment(.leading)
                                .font(.custom("Raleway-Bold", size: 20))
                                .foregroundColor(.titleColor)
                            Spacer()
                        }.padding([.top, .leading, .trailing])
                        
                        SubCardLink(category: category)
                        
                        if !category.subcategories.isEmpty {
                            HStack{
                                Text("Categorias")
                                    .font(.custom("Raleway-Bold", size: 20))
                                    .foregroundColor(.titleColor)
                                Spacer()
                            }.padding([.top, .leading, .trailing])
                            
                            VStack {
                                LazyVStack {
                                    ForEach(0..<category.subcategories.count, id: \.self) { count in
                                        SubCardsCategory(category: category, count: count)
                                    }
                                }
                            }.padding()
                        } else {
                            Spacer(minLength: 30)
                        }
                        //MARK: -Botao de pedir ajuda
                        
                        VStack {
                            Button(action: {
                                if (Auth.auth().currentUser?.isEmailVerified == false) {
                                    showSignInForm.toggle()
                                } else {
                                    self.showModal.toggle()
                                }
                            }, label: {
                                Spacer()
                                Image(systemName: "ellipses.bubble")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.lightColor)
                                    .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                Text("Pedir ajuda")
                                    .font(.custom("Raleway-Bold", size: 18))
                                    .foregroundColor(.lightColor)
                                Spacer()
                                
                            }).padding()
                            .clipped()
                            .background(Color.btnColor)
                            .cornerRadius(10)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .fullScreenCover(isPresented: $presented, content: {
                                //HelpUI()
                            })
                            .fullScreenCover(isPresented: $showSignInForm) {
                                //Pode dar bugs, falta verificar!
                                SignInView(userAuth: userAuth)
                            }
                            
                        }.padding()
                        
                        Spacer(minLength: 20)
                        
                    }.frame(height: geometry.size.height - ((geometry.size.height / 5)))
                    .navigationBarTitle("", displayMode: .inline)
                    //.navigationTitle(Text(""))
                    //.navigationBarHidden(true)
                    .statusBar(hidden: true)
                    
                    
                }
                .background(RoundedCorners(tl: 25, tr: 25, bl: 0, br: 0).fill(Color.backgroundColor))
                //.background(Color.backgroundColor) // ta mostrando o fundo de cores diferentes
                //.cornerRadius(25, corners: [.topLeft, .topRight])
                //.offset(x: 0, y: -35)
                .clipped()
                .shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 15, x: 0.0, y: -5.0)
                
            }.edgesIgnoringSafeArea(.top)
            .overlay(HelpUI(showModal: $showModal, completed: $completed).opacity(showModal ? 1 : 0).frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).animation(.easeInOut(duration: 0.3)))
            .overlay(DoubtSentUI(completed: $completed).opacity(completed ? 1 : 0).frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).animation(.easeInOut(duration: 0.3)))
            
        }
        
    }
    
}
//codigo pra apresentar a view controller de pedir ajuda
//    struct HelpUI: UIViewControllerRepresentable {
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return //view de pedir ajuda
//        }
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//
//        }
//    }

//    var helloColor: UIColor{
//        if didTap {
//            return .red
//        }else{
//            return .blue
//        }
//    }


//struct Subcategory_Previews: PreviewProvider {
//    static var previews: some View {
//        SubcategoryView()
//    }
//}
