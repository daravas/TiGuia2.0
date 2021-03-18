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
    
    @State var coordinator: SignInWithAppleCoordinator?
    
    var body: some View {
        VStack {
            Image("tiguia")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
            
            Spacer()
            
            SignInWithAppleButton()
                .frame(width: 280, height: 45)
                .onTapGesture { // (1)
                    
                    self.coordinator = SignInWithAppleCoordinator()
                    if let coordinator = self.coordinator {
                        coordinator.startSignInWithAppleFlow {
                            print("You successfully signed in")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    
                    //          self.signInWithAppleButtonTapped() // (2)
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

