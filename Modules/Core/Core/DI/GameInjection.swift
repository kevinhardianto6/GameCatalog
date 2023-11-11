//
//  Injection.swift
//  Catalog
//
//  Created by Kevin Hardianto on 02/01/23.
//

import UIKit

public class GameInjection: NSObject {
  public static func provideHome() -> HomeUseCase {
    let gameRepository = GameRepository.sharedInstance
    return HomeInteractor(gameRepository: gameRepository)
  }
  
  public static func provideDetail() -> DetailUseCase {
    let gameRepository = GameRepository.sharedInstance
    return DetailInteractor(gameRepository: gameRepository)
  }
  
  public static func provideFavourite() -> FavouriteUseCase {
    let gameRepository = GameRepository.sharedInstance
    return FavouriteInteractor(gameRepository: gameRepository)
  }
}
