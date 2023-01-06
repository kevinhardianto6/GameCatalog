//
//  FavouriteInteractor.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

import UIKit
import RxSwift

protocol FavouriteUseCase {
  func getAllFavouriteGames() -> Observable<[GameModel]>
  func deleteAllFavouriteGames() -> Observable<Bool>
  func getDetailGame(gameId: Int) -> Observable<GameDetailModel>
}

class FavouriteInteractor: FavouriteUseCase {
  
  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getAllFavouriteGames() -> Observable<[GameModel]> {
    return repository.getAllFavouriteGames()
  }
  
  func deleteAllFavouriteGames() -> Observable<Bool> {
    return repository.deleteAllFavouriteGames()
  }
  
  func getDetailGame(gameId: Int) -> Observable<GameDetailModel> {
    return repository.getDetailGame(gameId: gameId)
  }
}
