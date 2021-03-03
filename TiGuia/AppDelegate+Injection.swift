//
//  AppDelegate+Injection.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 02/03/21.
//

import Foundation
import Resolver
import Combine
import Firebase

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
    register { AuthenticationService() }.scope(.application)
    register { FirestoreTaskRepository() as TaskRepository }.scope(.application)
  }
}


