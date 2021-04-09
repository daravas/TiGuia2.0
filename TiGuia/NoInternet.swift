//
//  NoInternet.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 09/04/21.
//

import Foundation
import SwiftUI

struct NoInternetUI: View {
    
    @Binding var sent: Bool
    
    var body: some View {
        GeometryReader{ geometry in
            
            ZStack(alignment: .center) {
                
                GeometryReader { gmt in
                    Rectangle().fill(Color.black.opacity(0.5))
                        .frame(height: gmt.size.height, alignment: .center)
                }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .center){
                    Text("Parece que algo deu errado...")
                        .font(.custom("Raleway-Bold", size: 18.0))
                        .foregroundColor(.darkColor)
                        .padding()
                    Text("Verifique sua conexão com a internet \n e tente novamente")
                        .font(.custom("Raleway-Regular", size: 15.0))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 20.0)
                        .lineSpacing(2)

                    
                    Button(action: {
                        self.sent = false
                    }, label: {
                        Text("Fechar")
                            .font(.custom("Raleway-Bold", fixedSize: 18.0))
                            .foregroundColor(.lightColor)
                            .padding(.horizontal)
                    }).padding()
                    .clipped()
                    .background(Color.btnColor)
                    .cornerRadius(10)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                }.padding()
                .clipped()
                .background(Color.bgcardColor)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()

            }
        }
        
    }
}
