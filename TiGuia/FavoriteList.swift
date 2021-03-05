//
//  FavoriteList.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 17/11/20.
//

import Foundation
import SwiftUI

struct ImageOverlay: View {
    
    var title: String
    
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0)]), startPoint: .bottom, endPoint: .center)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                Rectangle().fill(gradient)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(10)
                //.offset(x: 14, y: -14)
                
                VStack(alignment: .leading) {
                    Text(title)
                        //.offset(x: 25, y: -25)
                        .font(.custom("Raleway-Bold", size: 16))
                        .lineLimit(4)
                        .foregroundColor(.lightColor)
                        .padding(9.0)
                        .lineSpacing(1)

                }
            }
        }
    }
}

struct Favorite: View {
    
    @State var presented = false
    @ObservedObject var subcategory = Data.favorite
    @State var selection: Int? = nil
    
    
     //   var imageFavorite = ["seguranca","cienciadedados","firewall","robotica"]
    
     //   var titleFavorite = ["Segurança \nda Informação", "Ciência de dados", "Gerenciamento \nde Firewall", "Robótica"]
    
    var collums = [
        // define number of caullum here
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                
                VStack(alignment: .leading) {
                    
                    
                        Image("favorito")
                            .resizable()
                            .scaledToFill()
                            .frame(height: (geometry.size.height/3) + 35, alignment: .center)
                            .edgesIgnoringSafeArea(.top)
                            .padding(.bottom, -(geometry.safeAreaInsets.top))
            

                    
//                    Rectangle().fill(Color.gray.opacity(0.5))
//                        .frame(height: geometry.size.height / 3, alignment: .center)
//                        .edgesIgnoringSafeArea(.top)
//                        .padding(.bottom, -(geometry.safeAreaInsets.top))
                    
                    VStack {
                        HStack{
                            Text("Favoritos")
                                .font(.custom("Raleway-Bold", size: 30))
                                .foregroundColor(.titleColor)
                            Spacer()
                        }.padding([.top, .leading, .trailing])
                        
                        ScrollView(.vertical) {
                            VStack {
                                if subcategory.subcategories.isEmpty {
                                    NothingHere()
                                        .frame(width: geometry.size.width, height: geometry.size.height/2, alignment: .center)
                                } else {
                                    LazyVGrid(columns: collums, alignment: .center, spacing: 0) {
                                        ForEach(0..<subcategory.subcategories.count, id: \.self) { count in
                                            
                                            NavigationLink(destination: PaginaConteudoView(favorito: subcategory.subcategories[count].favorite, category: subcategory.subcategories[count]), tag: count, selection: $selection) {
                                                Button(action: {
                                                    //self.presented.toggle()
                                                    self.selection = count
                                                }, label: {
                                                    Image(subcategory.subcategories[count].image ?? "seguranca" )
                                                        .resizable()
                                                        .frame(width: (geometry.size.width/2) - 25, height: 170)
                                                        .cornerRadius(10)
                                                        .overlay(ImageOverlay(title: subcategory.subcategories[count].title), alignment: .bottomLeading)
                                                })
                                                
                                            }
                                            //                                    .fullScreenCover(isPresented: $presented, content: {
                                            //                                        PaginaConteudoView(category: subcategory.subcategories[count])
                                            //
                                            //                                    })
                                        }.padding(.bottom)
                                        .shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 10, x: 0.0, y: 4.0)
                                    }.padding()
                                    //.aspectRatio(1, contentMode: .fit)
                                }
                            }
                            
                        }
                        //.offset(y: -15)
                        //.edgesIgnoringSafeArea(.bottom)
                        //Spacer()
                        
                    }
                    //.background(Color.backgroundColor) // ta mostrando o fundo de cores diferentes
                    //.cornerRadius(25, corners: [.topLeft, .topRight])
    //                    .offset(x: 0, y: -35)
                    .background(RoundedCorners(tl: 25, tr: 25, bl: 0, br: 0).fill(Color.backgroundColor)) // ta mostrando o fundo de cores diferentes
                    .clipped()
                    .shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 15, x: 0.0, y: -5.0)
                    .offset(y: -35)
                }
                .edgesIgnoringSafeArea(.bottom)
                //.offset(y: -50)
                .navigationBarTitle("")
                //.navigationBarHidden(true)
                
            }
            
        }.accentColor(.titleColor)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear(perform: {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
        })
    }
}

struct NothingHere: View {
    var body: some View{
        VStack (alignment: .center){
            Text("Nada aqui ainda!")
                .foregroundColor(.darkColor)
                .font(.custom("Raleway-Bold", size: 18))
                .multilineTextAlignment(.leading)
                .padding(.all, 2.0)
            Text("Navegue pelo conteúdo na aba Trilha e veja se encontra algo legal para salvar :)")
                .foregroundColor(.darkColor)
                .font(.custom("Raleway", size: 14))
                .lineSpacing(2)
                .multilineTextAlignment(.center)
                .frame(width: 260, alignment: .center)
        }
    }
}
// codigo para mostrar a view controller junto com o .fullScreenCover mostrado acima no botao
struct OtherUI: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        return FavoriteViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
    }
}
