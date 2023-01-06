//
//  MainTabController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 12/10/22.
//

import UIKit

class MainTabController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    let home = HomeViewController()
    let homeUseCase = Injection.init().provideHome()
    let homeViewModel = HomeViewModel(homeUseCase: homeUseCase)
    home.setViewModel(viewModel: homeViewModel)
    home.modalPresentationStyle = .fullScreen
    home.title = "Home"
    
    let favourite = FavouriteViewController()
    let favouriteUseCase = Injection.init().provideFavourite()
    let favouriteViewModel = FavouriteViewModel(favouriteUseCase: favouriteUseCase)
    favourite.setViewModel(viewModel: favouriteViewModel)
    favourite.modalPresentationStyle = .fullScreen
    favourite.title = "Favourite"
    
    let profile = ProfileViewController()
    let profilelUseCase = Injection.init().provideProfile()
    let profileViewModel = ProfileViewModel(profileUseCase: profilelUseCase)
    profile.setViewModel(viewModel: profileViewModel)
    profile.modalPresentationStyle = .fullScreen
    profile.title = "Profile"
    
    self.setViewControllers([home, favourite, profile], animated: false)
  
    self.tabBar.tintColor = UIColor.white
    self.tabBar.barTintColor = UIColor.black
    self.tabBar.layer.shadowColor = UIColor.white.cgColor
    self.tabBar.layer.shadowOffset = CGSize(width: 2,height: 5)
    self.tabBar.layer.shadowRadius = 20
    self.tabBar.layer.shadowOpacity = 1
    
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
  
  }
}
