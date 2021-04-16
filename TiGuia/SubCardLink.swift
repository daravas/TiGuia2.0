//
//  CardLink.swift
//
//
//  Created by Dara Vasconcelos on 16/11/20.
//

import SwiftUI

struct SubCardLink: View {
    
    @Environment(\.openURL) private var openURL
    var category:Subcategory
    
    var body: some View {
        
        HStack{
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0..<category.links.count, id: \.self) { count in
                        Button(action: {
                            let stringUrl = (category.links[count].url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            openURL(URL(string: stringUrl!)!)
                        }, label: {
                            Image(category.links[count].image!)
                                .resizable()
                                .frame(width: 164, height: 121)
                                .cornerRadius(10)
                                //.shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 10, x: 0.0, y: 4.0)
                                .overlay(ImageOverlayCardLink(title: category.links[count].titulo), alignment: .bottomLeading)
                        })
                        
                    }.padding(.trailing, 5.0)
                    .shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 8, x: 0.0, y: 4.0)
                }
                .padding(.all)
            }
        }
    }
}


struct SubCardsCategory: View {
    
    var category:Subcategory
    //@State var presented = false
    @State private var selection: Int? = nil
    var count: Int
    @ObservedObject var userVM: UserViewModel
    var body: some View {
        
        NavigationLink(destination: SubcategoryView(favorito: category.subcategories[count].favorite, userVM: userVM, category: category.subcategories[count]), tag: count, selection: $selection) {
            Button(action: {
                //self.presented.toggle()
                self.selection = count
            }, label: {
                HStack{
                    Image(category.subcategories[count].image!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipShape(Rectangle(), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                        .shadow(radius: 8)
                    VStack(alignment: .leading){
                        Text(category.subcategories[count].title)
                            .font(.custom("Raleway-Bold", size: 16))
                            .lineLimit(1)
                            .padding([.leading, .trailing], 5.0)
                            .padding(.bottom, 1)
                            .foregroundColor(.darkColor)
                        
                        
                        Text(category.subcategories[count].content)
                            .font(.custom("Raleway-Regular", size: 14))
                            .lineLimit(4)
                            .lineSpacing(1)
                            .padding([.leading, .bottom, .trailing], 5.0)
                            .foregroundColor(.darkColor)
                    }
                    Spacer()
                }.padding()
                .clipped()
                .background(Color.bgcardColor)
                .cornerRadius(10)
                
                
            }).padding(.bottom, 15.0)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
        }
    }
}
