//
//  FavouriteInteractor.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

import UIKit
import RxSwift

public protocol FavouriteUseCase {
  func getAllFavouriteGames() -> Observable<[GameModel]>
  func deleteAllFavouriteGames() -> Observable<Bool>
  func getDetailGame(gameId: Int) -> Observable<GameDetailModel>
}

public class FavouriteInteractor: FavouriteUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  required init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  public func getAllFavouriteGames() -> Observable<[GameModel]> {
    return gameRepository.getAllFavouriteGames()
  }
  
  public func deleteAllFavouriteGames() -> Observable<Bool> {
    return gameRepository.deleteAllFavouriteGames()
  }
  
  public func getDetailGame(gameId: Int) -> Observable<GameDetailModel> {
    return gameRepository.getDetailGame(gameId: gameId)
  }
}
