//
//  CardCategory.swift
//  TiGuia
//
//  Created by Dara Vasconcelos on 17/11/20.
//

import SwiftUI

struct CardsCategory: View {
    
    var category:Category
    //@State private var presented = false
    @State private var selection: Int? = nil
    
    var body: some View {
        
        VStack {
            LazyVStack {
                ForEach(0..<category.subcategories.count, id: \.self) { count in
                    
                    NavigationLink(destination: SubcategoryView(category: category.subcategories[count]), tag: count, selection: $selection) {
                        
                        Button(action: {
                            //self.presented.toggle()
                            self.selection = count
                        }, label: {
                            HStack{
                                Image(category.subcategories[count].image!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .clipShape(Rectangle(), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(10)
                                    .shadow(radius: 8)
                                VStack(alignment: .leading){
                                    Text(category.subcategories[count].title)
                                        .font(.custom("Raleway-SemiBold", size: 16))
                                        .padding([.leading, .bottom, .trailing], 5.0)
                                        .foregroundColor(.darkColor)
                                    
                                    
                                    Text(category.subcategories[count].content)
                                        .font(.custom("Raleway-Regular", size: 14))
                                        .lineLimit(4)
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
                    // NavigationLink(destination: SubcategoryView(category: category.subcategories[count]), isActive: $presented) { EmptyView() }
                    // NavigationLink(destination: SubcategoryView(category: category.subcategories[count]), tag: count, selection: $selection) { EmptyView() }
                    
                }
            }.padding(.all)
            
        }
    }
}
