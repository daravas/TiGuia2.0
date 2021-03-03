//
//  SignInWithAppleCoordinator.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 02/03/21.
//

import Foundation
import Resolver
import Firebase
import AuthenticationServices
import CryptoKit

enum SignInState: String {
    case signIn
    case link
    case reauth
}

class SignInWithAppleCoordinator: NSObject {
    @LazyInjected private var taskRepository: TaskRepository
    @LazyInjected private var authenticationService: AuthenticationService // (1)
    
    private weak var window: UIWindow!
    private var onSignedIn: ((User) -> Void)? // (2)
    
    private var currentNonce: String? // (3)
    
    private func appleIDRequest(withState: SignInState) -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest() // (1)
        request.requestedScopes = [.fullName, .email] // (2)
        request.state = withState.rawValue //(3)
        
        let nonce = randomNonceString() // (4)
        currentNonce = nonce
        request.nonce = sha256(nonce)
        
        return request
    }
    
    init(window: UIWindow?) {
        self.window = window
    }
    
}
