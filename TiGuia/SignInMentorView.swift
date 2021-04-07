//
//  SigInViewMentor.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 24/03/21.
//

import Foundation
import SwiftUI


struct SignInMentorView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var userVM: UserViewModel
    @State var coordinator: SignInWithAppleCoordinator?
    
    var body: some View {
        let buttonColor = Color(red: 28/255, green: 118/255, blue: 144/255, opacity: 1.0)
        VStack(alignment: .center) {
            Button(action: {
    //
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(buttonColor)
                    .padding(.trailing, 370.0)
            }
            Image("logotiguia")
                .resizable()
                .frame(width: 96, height: 149)
                .padding(.top, 80)
            
            Text("Faça login")
                .font(.custom("Raleway-Bold", size: 30))
                .foregroundColor(.titleColor)
                .padding(.top, 25)
            
            Text("Ao entrar você receberá as perguntas dos alunos que se interessam sobre a área de Computação!\n Faça parte da comunidade do TiGuia, você ajudará pessoas a encontrarem um caminho a seguir, fazendo-as compreender as áreas em que você atua.")
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
                            userVM.sendData(isSigned: true)
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }
                    }
                    
                } .padding(.top, 40)
                .cornerRadius(10)
                .shadow(radius: 10)
                
            Spacer()
        }
    }
}

//struct SignInViewMentor_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInMentorView()
//    }
//}

