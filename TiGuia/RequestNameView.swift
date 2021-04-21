//
//  RequestNameView.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 24/03/21.
//

import Foundation
import SwiftUI
import Firebase

struct RequestNameView: View {
    
    @State private var showConfigView = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var showThisView: Bool
    @Binding var showSignIn: Bool
    @Binding var userName: String
//    @Binding var userEmail: String = ""
//    @Binding var userPassword: String = ""
    var body: some View {
        
        
        VStack() {
            Spacer()
                .frame(height: 75.0)
            HStack {
                    Text("Como você gostaria de ser chamado?")
                    .font(.custom("Raleway-Bold", size: 30))
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(width: 350.0, alignment: .leading)
                    .foregroundColor(.darkColor)
                Spacer()
            }
            
            TextField("Digite o seu nome aqui", text: $userName)
                .padding()
                .padding(.bottom, 50)
            Spacer()
            
            VStack{
                
                Button(action: {
                    
                    SignInWithAppleCoordinator().changeName(displayName: userName)
                    showSignIn.toggle()
                    showThisView.toggle()
                    //presentationMode.wrappedValue.dismiss()
                    //showConfigView.toggle()
                    
                    
                }, label: {
                    Spacer()
                    Text("Continuar")
                        .font(.custom("Raleway-Bold", size: 18))
                        .foregroundColor(.lightColor)
                        .frame(alignment: .center)
                    Spacer()
                    
                    
                })
                .padding()
                .clipped()
                .background(Color.btnColor) // aqui precisou usar o Color.
                .cornerRadius(10)
                .shadow(radius: 10)
                .fullScreenCover(isPresented: $showConfigView) {
//                    ConfigView()
                }
                
            }
            .padding()
            
        }
//        .onAppear{print("\n\nappear\n\n")}
    }
    
}



//struct RequestNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestNameView()
//    }
//}
