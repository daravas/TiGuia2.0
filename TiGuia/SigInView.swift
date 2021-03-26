//
//  SigInView.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 02/03/21.
//

import Foundation
import SwiftUI


struct SignInView: View {
    //  @Environment(\.window) var window: UIWindow?
    @Environment(\.presentationMode) var presentationMode
    //
    //  @State var signInHandler: SignInWithAppleCoordinator?
    //
    
    @State private var showNameView = false
    
    
    @State var coordinator: SignInWithAppleCoordinator?
    
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
                            self.presentationMode.wrappedValue.dismiss()
                            showNameView.toggle()
                        }
                    }
                    
                    //          self.signInWithAppleButtonTapped() // (2)
                } .padding(.top, 40)
                .cornerRadius(10)
                .shadow(radius: 10)
            Spacer()
                .fullScreenCover(isPresented: $showNameView) {
                    RequestNameView()
                }
        }

    }
    
    //  func signInWithAppleButtonTapped() {
    //    signInHandler = SignInWithAppleCoordinator(window: self.window)
    //    signInHandler?.link { (user) in
    //      print("User signed in \(user.uid)")
    
    //      self.presentationMode.wrappedValue.dismiss() // (3)
    //    }
    //  }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

