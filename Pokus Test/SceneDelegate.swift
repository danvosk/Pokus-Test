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

//import UIKit
//import Firebase
//import FirebaseAuth
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//    var openedFromAkbankTest: Bool = false
//    var openedFromGarantiTest: Bool = false
//
//    var userEmailFromAkbank: String?
//    var userEmailFromGaranti: String?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let _ = (scene as? UIWindowScene) else { return }
//        
//        // Uygulama URL Scheme ile açılmış mı kontrol et
//        if let urlContext = connectionOptions.urlContexts.first {
//            let url = urlContext.url
//            // URL Scheme kontrolü ve host ayarlaması
//            if url.scheme == "pokustestScheme" {
//                if url.host == "akbank" {
//                    openedFromAkbankTest = true
//                    if let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems {
//                        userEmailFromAkbank = queryItems.first(where: { $0.name == "userEmail" })?.value
//                    }
//                } else if url.host == "garanti" {
//                    openedFromGarantiTest = true
//                    if let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems {
//                        userEmailFromGaranti = queryItems.first(where: { $0.name == "userEmail" })?.value
//                    }
//                }
//            }
//        }
//
//        // Başlangıç ViewController'ını yükle ve değişkenleri aktar
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let initialViewController = storyboard.instantiateInitialViewController() as? ViewController {
//            initialViewController.openedFromAkbankTest = true
////            initialViewController.openedFromGarantiTest = true
//            initialViewController.userEmailFromAkbank = userEmailFromAkbank
////            initialViewController.userEmailFromGaranti = userEmailFromGaranti
//            window?.rootViewController = initialViewController
//            window?.makeKeyAndVisible()
//        }
//    }
//
//    func sceneDidDisconnect(_ scene: UIScene) {}
//    func sceneDidBecomeActive(_ scene: UIScene) {}
//    func sceneWillResignActive(_ scene: UIScene) {}
//    func sceneWillEnterForeground(_ scene: UIScene) {}
//    func sceneDidEnterBackground(_ scene: UIScene) {}
//}
