//
//  SceneDelegate.swift
//  BottomDrawer
//
//  Created by doremin on 2/28/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    
    let mainViewController = MainViewController()
    window?.rootViewController = mainViewController
    window?.makeKeyAndVisible()
  }


}

