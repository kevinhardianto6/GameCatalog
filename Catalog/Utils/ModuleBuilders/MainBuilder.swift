//
//  GameBuilder.swift
//  Catalog
//
//  Created by Kevin Hardianto on 03/10/23.
//

import UIKit
import Profile
import Game
import Core

class MainBuilder {
  class func getView(module: MainModuleEnum) -> UIViewController {
    switch module {
    case .main:
      let main = MainTabController()
      return main
    case .splash:
      let splash = SplashViewController()
      return splash
    }
  }
}
