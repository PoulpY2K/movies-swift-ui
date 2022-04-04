//
//  SceneDelegate.swift
//  MoviesLive
//
//  Created by Digital on 29/03/2022.
//

import UIKit
import SwiftUI


class SceneDelegate: UIResponder, UIWindowSceneDelegate, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let rootViewController = MovieViewController(nibName: "MovieViewController", bundle: Bundle.main)
            let navigationController = UINavigationController(rootViewController: rootViewController)
            window.rootViewController = navigationController
            
            self.window = window
            self.window?.makeKeyAndVisible()
        }
    }
    
}
