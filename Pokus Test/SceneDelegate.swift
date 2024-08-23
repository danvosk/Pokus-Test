//
//  SceneDelegate.swift
//  Pokus Test
//
//  Created by Görkem Karagöz on 14.08.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var openedFromAkbankTest: Bool = false

    var userEmailFromAkbank: String?
    
      func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
          guard let _ = (scene as? UIWindowScene) else { return }
          
          if let urlContext = connectionOptions.urlContexts.first {
                      let url = urlContext.url
                      if url.scheme == "pokustestScheme" {
                          openedFromAkbankTest = true
                          if let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems {
                              userEmailFromAkbank = queryItems.first(where: { $0.name == "userEmail" })?.value
                          }
                      }
                  }

                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  if let initialViewController = storyboard.instantiateInitialViewController() as? ViewController {
                      initialViewController.openedFromAkbankTest = openedFromAkbankTest
                      initialViewController.userEmailFromAkbank = userEmailFromAkbank
                      window?.rootViewController = initialViewController
                      window?.makeKeyAndVisible()
                  }
              }
          
      }

  
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

