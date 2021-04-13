//
//  AppDelegate.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 04/11/20.
//

import UIKit
import Firebase
import Resolver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

//    @Injected var authenticationService: AuthenticationService
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        if Auth.auth().currentUser == nil {
            try Auth.auth().signInAnonymously(){_,_ in
                let userVM = UserViewModel()
                userVM.fetchData(isSigned: false)
            }
        }
                
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

