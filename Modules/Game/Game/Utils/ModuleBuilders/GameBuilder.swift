//
//  GameBuilder.swift
//  Catalog
//
//  Created by Kevin Hardianto on 03/10/23.
//

import UIKit

public class GameBuilder: NSObject {
  public class func getView(module: GameModuleEnum) -> UIViewController {
    switch module {
    case .home:
      let home = HomeViewController()
      let homeUseCase = GameInjection.provideHome()
      let homeViewModel = HomeViewModel(homeUseCase: homeUseCase)
      home.homeViewModel = homeViewModel
      return home
    case .detail(let game, let screenshots):
      let detail = DetailViewController(game: game, screenshots: screenshots)
      let detailUseCase = GameInjection.provideDetail()
      let detailViewModel = DetailViewModel(detailUseCase: detailUseCase)
      detail.detailViewModel = detailViewModel
      return detail
    case .favourite:
      let favourite = FavouriteViewController()
      let favouriteUseCase = GameInjection.provideFavourite()
      let favouriteViewModel = FavouriteViewModel(favouriteUseCase: favouriteUseCase)
      favourite.favouriteViewModel = favouriteViewModel
      return favourite
    }
  }
}
