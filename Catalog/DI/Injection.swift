//
//  Injection.swift
//  Catalog
//
//  Created by Kevin Hardianto on 02/01/23.
//

import UIKit

final class Injection: NSObject {
  
  private func provideGameRepository() -> GameRepositoryProtocol {
    let gameService: GameService = GameService.sharedInstance
    let gameProvider: GameProvider = GameProvider.sharedInstance
    
    return GameRepository.sharedInstance(gameProvider, gameService)
  }
  
  private func provideProfileRepository() -> ProfileRepositoryProtocol {
    let profileProvider: ProfileProvider = ProfileProvider.sharedInstance
    
    return ProfileRepository.sharedInstance(profileProvider)
  }
  
  func provideHome() -> HomeUseCase {
    let repository = provideGameRepository()
    return HomeInteractor(repository: repository)
  }
  
  func provideDetail() -> DetailUseCase {
    let repository = provideGameRepository()
    return DetailInteractor(repository: repository)
  }
  
  func provideProfile() -> ProfileUseCase {
    let repository = provideProfileRepository()
    return ProfileInteractor(repository: repository)
  }
  
  func provideFavourite() -> FavouriteUseCase {
    let repository = provideGameRepository()
    return FavouriteInteractor(repository: repository)
  }
}
