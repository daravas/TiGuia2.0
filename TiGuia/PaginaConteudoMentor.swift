//
//  PaginaConteudoMentor.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 08/12/20.
//

import Foundation
import SwiftUI
//titulo, conteúdo, links, cards subcategorias, btn favorito
public struct PaginaConteudoMentor: View {
    @State private var favorito: Bool = false
    @State private var presented: Bool = false
    @State var isExpanded: Bool = false
    @State var truncated: Bool = false
    @ObservedObject var mentorRep = MentorCategoryRepository()
    //var category = Data().returnCategory()
    
    //var index:Int
    
    var category:MentorSubcategory
    //var links = [Link]()
    init(category: MentorSubcategory){
        self.category = category
        mentorRep.fetchLinks(docId: category.docId)
    }
    static var favorite = Favorites()
    //var index:Int
    
    @Environment(\.openURL) private var openURL
    var collums = [
        // define number of caullum here
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.systemLightDark.opacity(0.8), Color.systemLightDark.opacity(0.2)]), startPoint: .center, endPoint: .top)
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
            VStack {
                //
                //MARK: -Header - titulo + botao de favoritos
                //
                HStack {
                    //título
                    Text(category.title)
                        .foregroundColor(.titleColor)
                        .font(.custom("Raleway-Bold", size: 30))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                }.padding()
                
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
                    
                    VStack{
                        LazyVGrid(columns: collums, alignment: .center, spacing: 0) {
                            ForEach(0..<self.mentorRep.links.count, id: \.self) { count in
                                Button(action: {
                                    let stringUrl = (self.mentorRep.links[count].url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                                    openURL(URL(string: stringUrl!)!)
                                }, label: {
                                    Image(self.mentorRep.links[count].image!)
                                        .resizable()
                                        .frame(width: (geometry.size.width/2) - 25, height: 170)
                                        .cornerRadius(10)
                                        //.shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 10, x: 0.0, y: 4.0)
                                        .overlay(ImageOverlayCardLink(title: self.mentorRep.links[count].titulo), alignment: .bottomLeading)
                                })
                                
                            }.padding(.bottom)
                            .shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 8, x: 0.0, y: 4.0)
                        }.padding()
                    }
                    
                }//.edgesIgnoringSafeArea(.top)
                //.navigationBarTitle("", displayMode: .inline)
                //.statusBar(hidden: true)
            }.navigationBarTitle("", displayMode: .inline)
            //.navigationTitle(Text(""))
            //.navigationBarHidden(true)
            .statusBar(hidden: true)
            
        }
        
        
    }
    
}
