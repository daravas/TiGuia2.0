//
//  TempUI.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 03/12/20.
//

import Foundation
import UIKit
import SwiftUI
import Firebase

struct TempUI: View {
    
    var body: some View {
        VStack(alignment: .center) {
            Image("temp")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 290, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("vai com calma,\(Auth.auth().currentUser!.displayName!)!")
                .foregroundColor(.titleColor)
                .font(.custom("Raleway-Bold", size: 30))
                .multilineTextAlignment(.leading)
                .padding(.all, 0.0)
            Text("ainda está em desenvolvimento :)")
                .foregroundColor(.darkColor)
                .font(.custom("Raleway", size: 18))
                .multilineTextAlignment(.center)
                .frame(width: 250, alignment: .center)
        }
    }
}

struct ChatTempUI_Previews: PreviewProvider {
    static var previews: some View {
        TempUI()
    }
}
