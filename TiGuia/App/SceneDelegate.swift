//
//  SceneDelegate.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 04/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private(set) static var shared: SceneDelegate?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //verifica se o modo correto é o light ou dark
        if (UserDefaults.standard.bool(forKey: "isDark") == false) {
            self.window!.overrideUserInterfaceStyle = .light
        } else {
            self.window!.overrideUserInterfaceStyle = .dark
        }
        //verifica se é a primeira vez do usuário no app para mostrar ou nao o onboarding
        if (UserDefaults.standard.bool(forKey: "notFirstInApp") == false) {
            UserDefaults.standard.set(true, forKey: "notFirstInApp")
            let viewController = storyboard.instantiateViewController(withIdentifier: "onboarding")
            self.window?.rootViewController = viewController
            
            self.window?.makeKeyAndVisible()
            
        } else{
            if(UserDefaults.standard.bool(forKey: "eAluno")){
                if(UserDefaults.standard.bool(forKey: "macroAreaSelected")){
                    //direcionar para a tela de conteudo
                    let viewController = storyboard.instantiateViewController(withIdentifier: "tabBar_vc")
                    self.window?.rootViewController = viewController
                }else{
                    //direcionar pra tela de categoria
                    let viewController = storyboard.instantiateViewController(withIdentifier: "macroareaStudent")
                    self.window?.rootViewController = viewController
                }
            }else if (UserDefaults.standard.bool(forKey: "eMentor")){
                if(UserDefaults.standard.bool(forKey: "macroAreaSelected")){
                    //direcionar para tela de areas
                    if(UserDefaults.standard.bool(forKey: "mentorAreaSelected")){
                        //direcionar para a tela principal do mentor
                        let viewController = storyboard.instantiateViewController(withIdentifier: "tabBarMentor_vc")
                        self.window?.rootViewController = viewController
                    }else{
                        //direcionar pra tela das escolhas de area
                        let viewController = storyboard.instantiateViewController(withIdentifier: "macroAreaMentor_vc")
                        self.window?.rootViewController = viewController
                    }
                }else{
                    //direcionar para tela de macroarea
                    let viewController = storyboard.instantiateViewController(withIdentifier: "macroAreaMentor_vc")
                    self.window?.rootViewController = viewController
                }
               
            }else{
                // let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let viewController = storyboard.instantiateViewController(withIdentifier: "firstVC")
                 self.window?.rootViewController = viewController
                
                 self.window?.makeKeyAndVisible()
            }
            
       
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
        Self.shared = self
        
        }
    
        
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    


