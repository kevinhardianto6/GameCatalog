//
//  MainTabController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 12/10/22.
//

import UIKit
import Game
import Profile
import Common

class MainTabController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    let home = GameBuilder.getView(module: .home)
    home.title = "Home"
    
    let favourite = GameBuilder.getView(module: .favourite)
    favourite.title = "Favourite"
    
    let profile = ProfileBuilder.getView(module: .profile)
    profile.title = "Profile"
    
    self.setViewControllers([home, favourite, profile], animated: false)
    
    self.tabBar.tintColor = UIColor.white
    self.tabBar.barTintColor = UIColor.black
    self.tabBar.layer.shadowColor = UIColor.white.cgColor
    self.tabBar.layer.shadowOffset = CGSize(width: 2,height: 5)
    self.tabBar.layer.shadowRadius = 20
    self.tabBar.layer.shadowOpacity = 0.3
    
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: CommonFontEnum.interSemiBold, size: 16) ?? UIFont.boldSystemFont(ofSize: 16)], for: .normal)
    
  }
}
