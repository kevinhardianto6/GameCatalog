//
//  AppDelegate.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import Core

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FontHelper.loadCoreFont()
    
    let navigationController = UINavigationController(rootViewController: MainBuilder.getView(module: .splash))
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }
}
