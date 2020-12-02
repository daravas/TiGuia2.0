//
//  SubareaMentor.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 01/12/20.
//

import Foundation
import SwiftUI

struct CardsAreaMentor: View {
    
    @State private var checkSelected: Bool = false
    
    let lightColor = Color("lightColor")
    let textColor = Color("darkColor")
    let category: Category
    
    var count: Int
    
    //    @State var presented = false
    
    //
    
    var body: some View {
        //  ZStack{
        VStack(alignment: .leading) {
            //  ScrollView(.vertical) {
            
//                    @ObservedObject var check = category.subcategories[count].$checkMentor
                    
                    Button(action: {
                        //                        self.presented.toggle()
                        self.checkSelected.toggle()
                        category.subcategories[count].checkMentor.toggle()
                        AreaMentorView.areasEscolhidas.append(category.subcategories[count])
                        
                    }, label: {
                        
                        HStack {
                            Image(category.subcategories[count].image!)
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .scaledToFill()
                                .clipShape(Rectangle(), style: FillStyle())
                                .cornerRadius(10)
                                .padding(.top)
                            VStack(alignment: .leading) {
                                
                                HStack(alignment: .top) {
                                    Text(category.subcategories[count].title)
                                        .font(.custom("Raleway-SemiBold", size: 16))
                                        .padding([.leading, .bottom], 5.0)
                                        .padding(.top)
                                        .foregroundColor(textColor)
                                        .lineLimit(1)
                                        Spacer()
                                    
                                    Image(systemName: "checkmark.square.fill")
                                        .frame(width: 18, height: 18)
                                        .foregroundColor(.btnColor)
                                        .padding([.top], 5)
                                        .opacity(self.checkSelected == false ? 0 : 1)
                                }
                                
                                Text(category.subcategories[count].content)
                                    .font(.custom("Raleway-Regular", size: 14))
                                    .padding([.leading, .bottom], 5.0)
                                    .foregroundColor(textColor)
                                    .lineLimit(4)
                                //Spacer()
                                
                            }
                            Spacer()
                            
                        }
                        .padding([.leading, .bottom])
                        .clipped()
                        .background(lightColor)
                        .cornerRadius(10)
                        
                    })
                    .padding(.bottom, 15)
                    .shadow(radius: 10)
        }
    }
}
