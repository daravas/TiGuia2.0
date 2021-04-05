//
//  SigInView.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 02/03/21.
//

import Foundation
import SwiftUI
import Firebase


struct SignInView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @StateObject var userAuth = UserAuth()
    
    @State private var showNameView = false
    
    @State var coordinator: SignInWithAppleCoordinator?
    
    @ObservedObject var userViewModel: UserViewModel
    
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            Image("logotiguia")
                .resizable()
                .frame(width: 96, height: 149)
                .padding(.top, 80)
            
            Text("Faça login")
                .font(.custom("Raleway-Bold", size: 30))
                .foregroundColor(.titleColor)
                .padding(.top, 25)
            
            Text("Ao entrar você terá acesso aos mentores que \n fazem parte da comunidade do TiGuia! \nUma conversa com profissionais e alunos da área \n pode te ajudar a entender melhor sobre o assunto\n e a tomar decisões.")
                .font(.custom("Raleway", size: 14))
                .foregroundColor(.darkColor)
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing])
                .lineSpacing(2)
            
            
            SignInWithAppleButton()
                .frame(width: 320, height: 45)
                .onTapGesture { // (1)
                    
                    self.coordinator = SignInWithAppleCoordinator()
                    if let coordinator = self.coordinator {
                        coordinator.startSignInWithAppleFlow {
                            print("You successfully signed in")
                            userAuth.isSigned = true
                            userViewModel.sendData(isSigned: true)
                            presentationMode.wrappedValue.dismiss()
//                            showNameView.toggle()
                        }
                    }
                    
                } .padding(.top, 40)
                .cornerRadius(10)
                .shadow(radius: 10)
            Spacer()
//                .fullScreenCover(isPresented: $showNameView) {
//                    RequestNameView()
//                }
        }

    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

